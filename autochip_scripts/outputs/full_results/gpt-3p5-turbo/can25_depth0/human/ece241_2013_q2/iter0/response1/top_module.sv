module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);


// We will create a truth table based on the given conditions
// The output will be 1 for inputs 2, 7, and 15
// The output will be 0 for inputs 0, 1, 4, 5, 6, 9, 10, 13, and 14
// The inputs 3, 8, 11, and 12 never occur in this system

// We can create the sum-of-products expression for this truth table

wire out_sop;
wire out_pos;

// SOP function
assign out_sop = (a & !b & !c & !d) |
                (!a & !b & !c & d) | 
                (!a & b & c & d);

// POS function 
assign out_pos = (a | b | c | d) & 
                (!a | !b | !c | d) & 
                (!a | b | !c | !d);
                

endmodule
