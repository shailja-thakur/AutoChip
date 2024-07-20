module top_module (
	input a,
	input b,
	input c,
	input d,
	output out_sop,
	output out_pos
);

// Define intermediate signals
wire[3:0] inputs;
wire out_sop_temp;

// Assign intermediate signals
assign {a,b,c,d} = inputs;
assign out_sop_temp = inputs == 2'b0010 || inputs == 2'b0111 || inputs == 2'b1111;

// Output assignments
assign out_sop = out_sop_temp;
assign out_pos = !out_sop_temp;

endmodule
