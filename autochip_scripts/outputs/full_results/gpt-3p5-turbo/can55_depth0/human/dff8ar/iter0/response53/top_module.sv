module top_module(
	input wire clk,
	input wire [7:0] d,
	input wire areset,
	output reg [7:0] q);

	reg [7:0] q_dff [7:0];

	always @(posedge clk or posedge areset) begin
		if (areset)
			q <= 8'b0;
		else begin
			q_dff[0] <= d[0];
			q_dff[1] <= d[1];
			q_dff[2] <= d[2];
			q_dff[3] <= d[3];
			q_dff[4] <= d[4];
			q_dff[5] <= d[5];
			q_dff[6] <= d[6];
			q_dff[7] <= d[7];
			q <= {q_dff[0], q_dff[1], q_dff[2], q_dff[3], q_dff[4], q_dff[5], q_dff[6], q_dff[7]};
		end
	end

endmodule
