module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	
	wire [3:0] carry;
	wire [3:0] xor_output;
	wire [3:1] carry_bit;

	genvar i;
	
	// Generate full adders
	generate
  		for (i = 0; i < 4; i = i + 1) begin : GEN_ADDER
    		full_adder FA(
      			.x(x[i]),
      			.y(y[i]),
      			.carry_in(carry[i]),
      			.sum_out(xor_output[i]),
      			.carry_out(carry[i+1])
    		);
  		end
	endgenerate
	
	// Connect carry bits
	assign carry_bit[0] = 0;
	assign carry_bit[1:4] = carry;
	
	// Concatenate sum bits with overflow bit
	assign sum = {carry_bit[4], xor_output};
	
endmodule
module full_adder (
	input x,
	input y,
	input carry_in,
	output sum_out,
	output carry_out
);

	assign sum_out = x ^ y ^ carry_in;
	assign carry_out = (x & y) | (x & carry_in) | (y & carry_in);
	
endmodule
