module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

// internal signals
wire [3:0] c; // carry
wire [3:0] s; // sum

// instantiate full adders
full_adder fa0(.a(x[0]), .b(y[0]), .ci(1'b0), .co(c[0]), .sum(s[0]));
full_adder fa1(.a(x[1]), .b(y[1]), .ci(c[0]), .co(c[1]), .sum(s[1]));
full_adder fa2(.a(x[2]), .b(y[2]), .ci(c[1]), .co(c[2]), .sum(s[2]));
full_adder fa3(.a(x[3]), .b(y[3]), .ci(c[2]), .co(c[3]), .sum(s[3]));

// final sum and overflow bit
assign sum = {c[3], s[3:0]};

endmodule
