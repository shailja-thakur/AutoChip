module top_module (
	input [3:0] x,
	input [3:0] y,
	output reg [4:0] sum
);

	always @(*) begin
		sum[0] = x[0] + y[0];
		sum[1] = x[1] + y[1];
		sum[2] = x[2] + y[2];
		sum[3] = x[3] + y[3];
		sum[4] = x[3] + y[3];
	end

endmodule
