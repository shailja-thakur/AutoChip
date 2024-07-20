module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [8:0] sum;
	wire [7:0] s;
	wire carry_out;
	wire sign_bit_a;
	wire sign_bit_b;
	wire sign_bit_s;
	wire overflow;

	assign sign_bit_a = a[7];
	assign sign_bit_b = b[7];
	assign sign_bit_s = s[7];

	assign s = sum[7:0];
	assign carry_out = sum[8];

	// Adder
	always @(a or b) begin
		sum = {1'b0, a} + {1'b0, b};
	end

	// Overflow detection
	always @(sum) begin
		if (sign_bit_a == sign_bit_b && sign_bit_a != sign_bit_s) begin
			overflow = 1'b1;
		end else begin
			overflow = 1'b0;
		end
	end
endmodule
