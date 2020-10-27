import sys
import os

DFILE_KEYWORDS = ["requirements", "types", "predicates", "action", "private", "functions", "constants"]
DFILE_REQ_KEYWORDS = ["typing", "strips", "multi-agent", "unfactored-privacy"]
DFILE_SUBKEYWORDS = ["parameters", "precondition", "effect", "duration"]
PFILE_KEYWORDS = ["objects", "init", "goal", "private", "metric"]
AFILE_KEYWORDS = ["agents"]

verbose = False


class Predicate(object):
    def __init__(self, name, args, is_typed, is_negated):
        self.name = name
        self.args = args
        self.arity = len(args)
        self.is_typed = is_typed
        self.is_negated = is_negated
        self.ground_facts = set()
        self.agent_param = -1

    def pddl_rep(self):
        rep = ''
        if self.is_negated:
            rep += "(not "
        if self.name != "":
            rep += "(" + self.name + " "
        else:
            rep += "("
        for argument in self.args:
            if self.is_typed:
                rep += argument[0] + " - " + argument[1] + " "
            else:
                rep += argument + " "
        rep = rep[:-1]
        rep += ")"
        if self.is_negated:
            rep += ")"
        return rep

    def __repr__(self):
        return self.pddl_rep()


class Action(object):
    def __init__(self, name, agent, parameters, precondition, effect):
        self.name = name
        self.parameters = parameters
        self.precondition = precondition
        self.effect = effect
        self.duration = 1
        self.agent = agent
        self.agent_type = ""

    def pddl_rep(self):
        rep = ''
        rep += "(:durative-action " + self.name + "\n"
        rep += "\t:parameters " + str(self.parameters) + "\n"
        rep += "\t:duration (= ?duration " + str(self.duration) + ")\n"
        rep += "\t:condition (and\n"
        for precon in self.precondition:
            rep += "\t\t" + "(at start " + str(precon) + ")\n"
        for ag in self.agent:
            rep += "\t\t" + "(at start (xfreex " + str(ag[0]) + "))\n"
        rep += "\t)\n"
        '''if len(self.effect) > 1:
            rep += "\t:effect (and\n"
        else:
            rep += "\t:effect \n"'''
        rep += "\t:effect (and\n"
        for eff in self.effect:
            if "not" in str(eff):
                rep += "\t\t" + "(at start " + str(eff) + ")\n"
            else:
                rep += "\t\t" + "(at end " + str(eff) + ")\n"
        for ag in self.agent:
            rep += "\t\t" + "(at start (not (xfreex " + str(ag[0]) + ")))\n"
            rep += "\t\t" + "(at end (xfreex " + str(ag[0]) + "))\n"
        rep += "\t)\n"
        rep += ")\n"
        return rep

    def __repr__(self):
        return self.name  # + str(self.parameters)


class Function(object):
    def __init__(self, obj_list):
        self.obj_list = obj_list

    def pddl_rep(self):
        rep = '('
        for argument in self.obj_list:
            rep += argument + " "
        rep = rep[:-1]
        rep += ") - number"
        return rep

    def __repr__(self):
        return self.pddl_rep()


class GroundFunction(object):
    def __init__(self, obj_list):
        self.obj_list = obj_list

    def pddl_rep(self):
        rep = '(' + self.obj_list[0] + " ("
        for argument in self.obj_list[1:-1]:
            rep += argument + " "
        rep = rep[:-1]
        rep += ") " + self.obj_list[-1] + ") "
        return rep

    def __repr__(self):
        return self.pddl_rep()


class PlanningProblem(object):
    def __init__(self, domainfile, problemfile):
        self.domain = ''
        self.requirements = set()
        self.type_list = set()
        self.type_list.add('object')
        self.types = {}
        self.predicates = []
        self.functions = []
        self.ground_functions = []
        self.actions = []
        self.agent_types = set()
        self.agents = set()
        self.problem = ''
        self.object_list = set()
        self.objects = {}
        self.constants = {}
        self.init = []
        self.goal = []
        self.metric = False

        self.parse_domain(domainfile)
        self.parse_problem(problemfile)

        for t in self.agent_types:
            self.agents = self.agents | self.get_objects_of_type(t)

        self.requirements = self.requirements - {"multi-agent", "unfactored-privacy"}

    def parse_domain(self, domainfile):
        with open(domainfile) as dfile:
            dfile_array = self._get_file_as_array(dfile)
        if dfile_array[0:4] != ['(', 'define', '(', 'domain']:
            print('PARSING ERROR: Expected (define (domain ... at start of domain file')
            sys.exit()
        self.domain = dfile_array[4]

        dfile_array = dfile_array[6:-1]
        opencounter = 0
        keyword = ''
        obj_list = []
        is_obj_list = True
        for word in dfile_array:
            if word == '(':
                opencounter += 1
            elif word == ')':
                opencounter -= 1
            elif word.startswith(':'):
                if word[1:] not in DFILE_KEYWORDS:
                    pass
                elif keyword != 'requirements':
                    keyword = word[1:]
            if opencounter == 0:
                if keyword == 'action':
                    self.actions.append(obj_list)
                    obj_list = []
                if keyword == 'types':
                    for element in obj_list:
                        self.types.setdefault('object', []).append(element)
                        self.type_list.add('object')
                        self.type_list.add(element)
                    obj_list = []
                keyword = ''

            if keyword == 'requirements':  # Requirements list
                if word != ':requirements':
                    if not word.startswith(':'):
                        print('PARSING ERROR: Expected requirement to start with :')
                        sys.exit()
                    elif word[1:] not in DFILE_REQ_KEYWORDS:
                        print('WARNING: Unknown Rquierement ' + word[1:])
                        # print 'Requirements must only be: ' + str(DFILE_REQ_KEYWORDS)
                        # sys.exit()
                    else:
                        self.requirements.add(word[1:])
            elif keyword == 'action':
                obj_list.append(word)
            elif not word.startswith(':'):
                if keyword == 'types':
                    if is_obj_list:
                        if word == '-':
                            is_obj_list = False
                        else:
                            obj_list.append(word)
                    else:
                        # word is type
                        for element in obj_list:
                            if not word in self.type_list:
                                self.types.setdefault('object', []).append(word)
                                self.type_list.add(word)
                            self.types.setdefault(word, []).append(element)
                            self.type_list.add(element)
                            self.type_list.add(word)
                        is_obj_list = True
                        obj_list = []
                elif keyword == 'constants':
                    if is_obj_list:
                        if word == '-':
                            is_obj_list = False
                        else:
                            obj_list.append(word)
                    else:
                        # word is type
                        for element in obj_list:
                            if word in self.type_list:
                                self.constants.setdefault(word, []).append(element)
                                # self.object_list.add(element)
                            else:
                                print(self.type_list)
                                print("ERROR unknown type " + word)
                                sys.exit()
                        is_obj_list = True
                        obj_list = []
                elif keyword == 'predicates' or keyword == 'private':  # Internally typed predicates
                    if word == ')':
                        if keyword == 'private':
                            # print "...skip agent: " +  str(obj_list[:3])
                            obj_list = obj_list[3:]
                            keyword = 'predicates'
                        if len(obj_list) == 0:
                            # print "...skip )"
                            continue
                        p_name = obj_list[0]
                        # print "parse predicate: " + p_name + " " + str(obj_list)
                        pred_list = self._parse_name_type_pairs(obj_list[1:], self.type_list)
                        self.predicates.append(Predicate(p_name, pred_list, True, False))
                        obj_list = []
                    elif word != '(':
                        obj_list.append(word)
                elif keyword == 'functions':  # functions
                    if word == ')':
                        p_name = obj_list[0]
                        if obj_list[0] == '-':
                            obj_list = obj_list[2:]
                        # print "function: " + word + " - " + str(obj_list)
                        self.functions.append(Function(obj_list))
                        obj_list = []
                    elif word != '(':
                        obj_list.append(word)

        new_actions = []
        for action in self.actions:
            if action[0] == '-':
                action = action[2:]
            act_name = action[1]
            act = {}
            action = action[2:]
            keyword = ''
            for word in action:
                if word.startswith(':'):
                    keyword = word[1:]
                else:
                    act.setdefault(keyword, []).append(word)
            self.agent_types.add(act.get('agent')[2])
            agent = self._parse_name_type_pairs(act.get('agent'), self.type_list)
            param_list = agent + self._parse_name_type_pairs(act.get('parameters')[1:-1], self.type_list)
            up_params = Predicate('', param_list, True, False)
            pre_list = self._parse_unground_propositions(act.get('precondition'))
            eff_list = self._parse_unground_propositions(act.get('effect'))
            new_act = Action(act_name, agent, up_params, pre_list, eff_list)

            new_actions.append(new_act)
        self.actions = new_actions

    def parse_problem(self, problemfile):
        with open(problemfile) as pfile:
            pfile_array = self._get_file_as_array(pfile)
        if pfile_array[0:4] != ['(', 'define', '(', 'problem']:
            print('PARSING ERROR: Expected (define (problem ... at start of problem file')
            sys.exit()
        self.problem = pfile_array[4]
        if pfile_array[5:8] != [')', '(', ':domain']:
            print('PARSING ERROR: Expected (:domain ...) after (define (problem ...)')
            sys.exit()
        if self.domain != pfile_array[8]:
            print('ERROR - names don\'t match between domain and problem file.')
            # sys.exit()
        if pfile_array[9] != ')':
            print('PARSING ERROR: Expected end of domain declaration')
            sys.exit()
        pfile_array = pfile_array[10:-1]

        opencounter = 0
        keyword = ''
        is_obj_list = True
        is_function = False
        obj_list = []
        int_opencounter = 0
        for word in pfile_array:
            if word == '(':
                opencounter += 1
            elif word == ')':
                if keyword == 'objects':
                    obj_list = []
                opencounter -= 1
            elif word.startswith(':'):
                if word[1:] not in PFILE_KEYWORDS:
                    print('PARSING ERROR: Unknown keyword: ' + word[1:])
                    print('Known keywords: ' + str(PFILE_KEYWORDS))
                else:
                    keyword = word[1:]
            if opencounter == 0:
                keyword = ''

            if not word.startswith(':'):
                if keyword == 'objects' or keyword == 'private':  # Typed list of objects
                    # print "word: " + word
                    # print "obj_list: " + str(obj_list)
                    if keyword == 'private':
                        # print "...skip agent: " +  word
                        obj_list = []
                        keyword = 'objects'
                        continue
                    if is_obj_list:
                        if word == '-':
                            is_obj_list = False
                        else:
                            obj_list.append(word)
                    else:
                        # word is type
                        for element in obj_list:
                            if word in self.type_list:
                                self.objects.setdefault(word, []).append(element)
                                self.object_list.add(element)
                            else:
                                print(self.type_list)
                                print("ERROR unknown type " + word)
                                sys.exit()
                        is_obj_list = True
                        obj_list = []
                elif keyword == 'init':
                    if word == ')':
                        if obj_list[0] == '=' and is_function == False:
                            is_function = True
                        else:
                            if is_function:
                                # print "function: " + str(obj_list)
                                self.ground_functions.append(GroundFunction(obj_list))
                                is_function = False
                            else:
                                # print "predicate: " + str(obj_list)
                                self.init.append(Predicate(obj_list[0], obj_list[1:], False, False))
                            obj_list = []
                    elif word != '(':
                        obj_list.append(word)
                elif keyword == 'goal':
                    if word == '(':
                        int_opencounter += 1
                    elif word == ')':
                        int_opencounter -= 1
                    obj_list.append(word)
                    if int_opencounter == 0:
                        self.goal = self._parse_unground_propositions(obj_list)
                        obj_list = []
                elif keyword == 'metric':
                    self.metric = True
                    obj_list = []

    def get_type_of_object(self, obj):
        for t in self.objects.keys():
            if obj in self.objects[t]:
                return t
        for t in self.constants.keys():
            if obj in self.constants[t]:
                return t

    def get_objects_of_type(self, of_type):
        # print "get objects of type " + of_type
        selected_types = {of_type}
        pre_size = 0
        while len(selected_types) > pre_size:
            pre_size = len(selected_types)
            for t in selected_types:
                if t in self.types:
                    selected_types = selected_types | set(self.types[t])
        # print selected_types
        selected_objects = set()
        for t in selected_types:
            if t in self.objects:
                selected_objects = selected_objects | set(self.objects[t])
            if t in self.constants:
                selected_objects = selected_objects | set(self.constants[t])
        return selected_objects

    def print_domain(self):
        print('\n*****************' + '\nDOMAIN: ' + self.domain + '\nREQUIREMENTS: ' + str(self.requirements)
              + '\nTYPES: ' + str(self.types) + '\nPREDICATES: ' + str(self.predicates) + '\nACTIONS: ' + str(self.actions)
              + '\nFUNCTIONS: ' + str(self.functions) + '\nCONSTANTS: ' + str(self.constants) + '\n****************')

    def print_problem(self):
        print('\n*****************\nPROBLEM: ' + self.problem + '\nOBJECTS: ' + str(self.objects) + '\nINIT: ' + str(self.init)
              + '\nGOAL: ' + str(self.goal) + '\nAGENTS: ' + str(self.agents) + '\n****************')

    def _get_file_as_array(self, file_):
        file_as_string = ""
        for line in file_:
            if ";" in line:
                line = line[:line.find(";")]
            line = (line.replace('\t', '').replace('\n', ' ')
                    .replace('(', ' ( ').replace(')', ' ) '))
            file_as_string += line
        file_.close()
        return file_as_string.strip().split()

    def _parse_name_type_pairs(self, array, types):
        pred_list = []
        if len(array) % 3 != 0:
            print("Expected predicate to be typed " + str(array))
            sys.exit()
        for i in range(0, int(len(array) / 3)):
            if array[3 * i + 1] != '-':
                print("Expected predicate to be typed")
                sys.exit()
            if array[3 * i + 2] in types:
                pred_list.append((array[3 * i], array[3 * i + 2]))
            else:
                print("PARSING ERROR {} not in types list".format(array[3 * i + 2]))
                print("Types list: {}".format(self.type_list))
                sys.exit()
        return pred_list

    def _parse_unground_proposition(self, array):
        negative = False
        if array[1] == 'not':
            negative = True
            array = array[2:-1]
        return Predicate(array[1], array[2:-1], False, negative)

    def _parse_unground_propositions(self, array):
        prop_list = []
        if array[0:3] == ['(', 'and', '(']:
            array = array[2:-1]
        opencounter = 0
        prop = []
        for word in array:
            if word == '(':
                opencounter += 1
            if word == ')':
                opencounter -= 1
            prop.append(word)
            if opencounter == 0:
                prop_list.append(self._parse_unground_proposition(prop))
                prop = []
        # print array[:array.index(')') + 1]
        return prop_list

    def write_pddl_domain(self, output_file):
        file_ = open(output_file, 'w')
        to_write = "(define (domain " + self.domain + ")\n"
        # Requirements
        to_write += "\t(:requirements"
        for r in self.requirements:
            to_write += " :" + r
        to_write += " :fluents :durative-actions"
        to_write += ")\n"
        # Types
        to_write += "(:types\n"
        agl = "\t"
        for type_ in self.types:
            l = set()
            for key in self.types.get(type_):
                if key in self.agent_types:
                    agl += key + " "
                if type_ != "agent":
                    l.add(key)
            if len(l) > 0:
                to_write += "\t"
                for i in l:
                    to_write += i + " "
                to_write += "- " + type_
                to_write += "\n"
        to_write += agl + "- " + "agent\n"
        to_write += ")\n"
        # Constants
        if len(self.constants) > 0:
            to_write += "(:constants\n"
            for t in self.constants.keys():
                to_write += "\t"
                for c in self.constants[t]:
                    to_write += c + " "
                to_write += " - " + t + "\n"
            to_write += ")\n"
        # Public predicates
        to_write += "(:predicates\n"
        to_write += "\t(xfreex ?agent - agent)\n"
        for predicate in self.predicates:
            to_write += "\t{}\n".format(predicate.pddl_rep())
        to_write += ")\n"
        # Functions
        if len(self.functions) > 0:
            to_write += "(:functions\n"
            for function in self.functions:
                to_write += "\t{}\n".format(function.pddl_rep())
            to_write += ")\n"
        # Actions
        for action in self.actions:
            to_write += "\n{}\n".format(action.pddl_rep())

        to_write += ")"
        file_.write(to_write)
        file_.close()

    def write_pddl_problem(self, output_file):
        file_ = open(output_file, 'w')
        to_write = "(define (problem " + self.problem + ") "
        to_write += "(:domain " + self.domain + ")\n"
        # Objects
        to_write += "(:objects\n"
        for obj in self.object_list:
            to_write += "\t" + obj + " - " + self.get_type_of_object(obj) + "\n"
        to_write += ")\n"
        to_write += "(:init\n"
        for ag in self.agents:
            to_write += "\t(xfreex " + ag +")\n"
        for predicate in self.init:
            to_write += "\t{}\n".format(predicate)
        for function in self.ground_functions:
            to_write += "\t{}\n".format(function)
        to_write += ")\n"
        to_write += "(:goal\n\t(and\n"
        for goal in self.goal:
            to_write += "\t\t{}\n".format(goal)
        to_write += "\t)\n)\n"
        if self.metric:
            to_write += "(:metric minimize (total-cost))\n"
        to_write += ")"
        file_.write(to_write)
        file_.close()

    def write_addl(self, output_file):
        file_ = open(output_file, 'w')
        to_write = "(define (problem " + self.problem + ") "
        to_write += "(:domain " + self.domain + ")\n"
        # Objects
        to_write += "(:agents"
        for obj in self.agents:
            to_write += " " + obj
        to_write += ")\n"
        to_write += ")"
        file_.write(to_write)
        file_.close()

    def write_agent_list(self, output_file):
        file_ = open(output_file, 'w')
        to_write = ""
        for obj in self.agents:
            to_write += obj + "\n"
        file_.write(to_write)
        file_.close()


if __name__ == "__main__":
    if len(sys.argv) < 4:
        print('Requires 3 args')
        print('arg1: folder')
        print('arg2: domain')
        print('arg3: problem')
    else:
        pp = PlanningProblem(sys.argv[1] + "/" + sys.argv[2] + ".pddl", sys.argv[1] + "/" + sys.argv[3] + ".pddl")

        if verbose:
            pp.print_domain()
            pp.print_problem()

        if not os.path.exists(sys.argv[1]):
            os.mkdir(sys.argv[1])

        pp.write_pddl_domain(sys.argv[1] + "/" + sys.argv[2] + "S.pddl")
        pp.write_pddl_problem(sys.argv[1] + "/" + sys.argv[3] + "S.pddl")
        pp.write_addl(sys.argv[1] + "/" + sys.argv[3] + ".addl")
        pp.write_agent_list(sys.argv[1] + "/" + sys.argv[3] + ".agents")
