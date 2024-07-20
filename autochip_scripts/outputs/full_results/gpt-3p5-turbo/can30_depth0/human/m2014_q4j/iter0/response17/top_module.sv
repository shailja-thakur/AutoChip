module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] carry;
wire [3:0] out;
wire overflow;

assign carry[0] = 1'b0;
assign {carry[1], out[0]} = x[0] + y[0] + carry[0];
assign {carry[2], out[1]} = x[1] + y[1] + carry[1];
assign {carry[3], out[2]} = x[2] + y[2] + carry[2];
assign {overflow, out[3]} = x[3] + y[3] + carry[3];

assign sum = {out, overflow};

endmodule
