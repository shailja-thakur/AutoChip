module top_module (
	input [7:0] a,
	input [7:0] b,
	output [7:0] s,
	output overflow
);

	reg [8:0] temp_sum;
	reg [7:0] sum;

	assign overflow = temp_sum[8];

	always @ (a or b) begin
		temp_sum = a + b;
		sum = temp_sum[7:0];
	end

	assign s = sum;

endmodule
