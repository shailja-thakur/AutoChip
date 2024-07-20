module top_module (
	input clk,
	input enable,
	input S,
	input A,
	input B,
	input C,
	output reg Z
);
	reg [7:0] q;

	always @(posedge clk) begin
		if(enable)
			q <= {S, q[7:1]};
	end

	assign Z = q[A:C];

endmodule
