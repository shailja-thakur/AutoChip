module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

// Declare the signals
wire [3:0] carry;
wire [3:0] xor_out;
wire [2:0] carry_out;

// Instantiate the full adders
full_adder FA0 (.a(x[0]), .b(y[0]), .c_in(1'b0), .sum(sum[0]), .c_out(carry[0]));
full_adder FA1 (.a(x[1]), .b(y[1]), .c_in(carry[0]), .sum(sum[1]), .c_out(carry[1]));
full_adder FA2 (.a(x[2]), .b(y[2]), .c_in(carry[1]), .sum(sum[2]), .c_out(carry[2]));
full_adder FA3 (.a(x[3]), .b(y[3]), .c_in(carry[2]), .sum(sum[3]), .c_out(carry[3]));

// Connect the carry outputs of full adders
assign carry_out[0] = carry[0];
assign carry_out[1] = carry[1];
assign carry_out[2] = carry[2];

// Add the carry_out signal to the sum
assign sum[4] = carry_out[2];
assign sum[3] = carry_out[1];
assign sum[2] = carry_out[0];
assign sum[1] = sum[0];
assign sum[0] = FA0.c_out;

endmodule
