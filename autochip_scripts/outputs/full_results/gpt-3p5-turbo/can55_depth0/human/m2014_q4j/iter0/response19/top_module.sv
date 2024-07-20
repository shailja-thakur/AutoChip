module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);

wire [3:0] sum_bits;
wire carry_out;

// Full Adder
assign sum_bits[0] = x[0] ^ y[0];
assign carry_out[0] = x[0] & y[0];

assign sum_bits[1] = x[1] ^ y[1] ^ carry_out[0];
assign carry_out[1] = (x[1] & y[1]) | (x[1] & carry_out[0]) | (y[1] & carry_out[0]);

assign sum_bits[2] = x[2] ^ y[2] ^ carry_out[1];
assign carry_out[2] = (x[2] & y[2]) | (x[2] & carry_out[1]) | (y[2] & carry_out[1]);

assign sum_bits[3] = x[3] ^ y[3] ^ carry_out[2];
assign carry_out[3] = (x[3] & y[3]) | (x[3] & carry_out[2]) | (y[3] & carry_out[2]);

assign sum[0] = sum_bits[0];
assign sum[1] = sum_bits[1];
assign sum[2] = sum_bits[2];
assign sum[3] = sum_bits[3];
assign sum[4] = carry_out[3];

endmodule
