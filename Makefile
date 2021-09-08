#############
# Inventory #
#############

main_source_files=$(shell find src -name *.cpp)
test_source_files=test/TestMain.cpp  # @todo Remove that file, and compile each test file independently

main_object_files=$(foreach file,$(main_source_files),$(patsubst src/%.cpp,build/obj/%.o,$(file)))
test_object_files=$(foreach file,$(test_source_files),$(patsubst test/%.cpp,build/obj/%.o,$(file)))
all_object_files=$(main_object_files) $(test_object_files)

test_sentinel_files=build/test/TestMain.ok  # @todo Split in many independent executables

#####################
# Top-level targets #
#####################

.PHONY: default
default: test link

.PHONY: compile
compile: $(all_object_files)

.PHONY: link
link: build/bin/TestMain build/bin/fastpl

.PHONY: test
test: $(test_sentinel_files)

#################
# Generic rules #
#################

# - compile a source file
build/obj/%.o: */%.cpp
	@mkdir -p $(dir $@)
	@echo "g++ -c  $< -o $@"
	@g++ -std=c++2a -c $< -o $@

# - run a test executable
build/test/%.ok: build/bin/%
	@mkdir -p $(dir $@)
	@echo $<
	@$<
	@touch $@

##################
# Specific rules #
##################

modules_in_linkable_order=\
	types/DataGenerator types/Criteria types/PerformanceTable types/MRSortModel types/AlternativesPerformance \
	learning/ProfileUpdater learning/ProfileInitializer learning/WeightUpdater \
	types/Criterion types/Perf types/Categories types/Category types/Profiles \
	learning/LinearSolver learning/HeuristicPipeline

build/bin/fastpl: $(foreach name,main app $(modules_in_linkable_order),build/obj/$(name).o)
	@mkdir -p $(dir $@)
	@echo "g++     $< -o $@"
	@g++ $^ -lyaml-cpp -lpugixml -lortools -o $@

build/bin/TestMain: $(foreach name,TestMain $(modules_in_linkable_order),build/obj/$(name).o)
	@mkdir -p $(dir $@)
	@echo "g++     $< -o $@"
	@g++ $^ -lgtest -lpugixml -lortools -pthread -o $@
