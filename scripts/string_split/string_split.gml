/// @param str
/// @param substr
function string_split(str, substr) {
	var terms, idx;
	idx = 0;
	terms = array_create(string_count(substr, str) + 1, "");
	for(var i = 1; i <= string_length(str); i++) {
		if(string_copy(str, i, string_length(substr)) == substr) {
			terms[++idx] = "";
			i += string_length(substr) - 1;
		} else {
			terms[idx] += string_char_at(str, i);
		}
	}
	
	return terms;
}