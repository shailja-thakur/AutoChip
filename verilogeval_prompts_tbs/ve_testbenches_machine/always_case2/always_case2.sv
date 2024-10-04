// 	In this module, "in" is the input and "pos" is the output.
	"pos" will be set to different values depending on the value of "in".
	The case statement uses the value of "in" to set the value of "pos".
	If "in" is 0, "pos" will be set to 0.
	If "in" is 1, "pos" will be set to 0.
	If "in" is 2, "pos" will be set to 1.
	If "in" is 3, "pos" will be set to 0.
	If "in" is 4, "pos" will be set to 2.
	If "in" is 5, "pos" will be set to 0.
	If "in" is 6, "pos" will be set to 1.
	If "in" is 7, "pos" will be set to 0.
	If "in" is 8, "pos" will be set to 3.
	If "in" is 9, "pos" will be set to 0.
	If "in" is 10, "pos" will be set to 1.
	If "in" is 11, "pos" will be set to 0.
	If "in" is 12, "pos" will be set to 2.
	If "in" is 13, "pos" will be set to 0.
	If "in" is 14, "pos" will be set to 1.
	If "in" is 15, "pos" will be set to 0.
	In all other cases "pos" will be set to 0.
	The value of "pos" is set every clock cycle.


module top_module (
	input [3:0] in,
	output reg [1:0] pos
);
