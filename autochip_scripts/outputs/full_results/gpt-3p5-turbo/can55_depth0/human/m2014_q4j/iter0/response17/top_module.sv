module top_module (
	input [3:0] x,
	input [3:0] y,
	output [4:0] sum
);
	// Internal signals
	wire [3:0] carry;
	
	// Full adder instances
	genvar i;
	generate
		for (i=0; i<4; i=i+1)
		begin: fa_instance
			full_adder full_adder_inst (
				.a(x[i]),
				.b(y[i]),
				.carry_in(i == 0 ? 1'b0 : carry[i-1]),
				.sum(sum[i]),
				.carry_out(carry[i])
			);
		end
	endgenerate
	
	// Overflow bit
	assign sum[4] = carry[3];
	
endmodule
module full_adder (
	input a,
	input b,
	input carry_in,
	output sum,
	output carry_out
);
	
	assign sum = a ^ b ^ carry_in;
	assign carry_out = (a & b) | (a & carry_in) | (b & carry_in);
	
endmodule
