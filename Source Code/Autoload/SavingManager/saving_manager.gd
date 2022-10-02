extends Node

const file_name = "user://saves.save"


func save(var thing_to_save):
	var file = File.new()
	file.open(file_name, File.WRITE)
#	if(len(thing_to_save) > 1):
#		for i in thing_to_save.keys():
#			file.store_var({i: thing_to_save[i]})
#	else:
	file.store_var(thing_to_save, true)
	file.close()


func loadData () -> Dictionary:
	var file = File.new()
	if not file.file_exists(file_name):
		var data = {"music": 80, "new_game": true, "points": 0, "selected_orgs": [], "explored_orgs": []}
		save(data)
		
	file.open(file_name, File.READ)
	var ans = file.get_var(true)
	file.close()
	return ans
	
func loadDict (name_of_file) -> Dictionary:
	var file = File.new()
	file.open(name_of_file, File.READ)
	var text = file.get_as_text()
	var dict = {}
	dict = parse_json(text)
	file.close()
	return dict
	
	
func merge_dict(dict_1: Dictionary, dict_2: Dictionary, deep_merge: bool = false) -> Dictionary:
	var new_dict = dict_1.duplicate(true)
	for key in dict_2:
		if key in new_dict:
			if deep_merge and dict_1[key] is Dictionary and dict_2[key] is Dictionary:
				new_dict[key] = merge_dict(dict_1[key], dict_2[key])
			else:
				new_dict[key] = dict_2[key]
		else:
			new_dict[key] = dict_2[key]
	return new_dict
