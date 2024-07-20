module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	reg [15:0] q_temp;
	reg [15:0] d_temp;

	always @(posedge clk) begin
		if (!resetn) begin
			q_temp <= 16'b0;
		end else begin
			d_temp[7:0] <= (byteena[0]) ? d[7:0] : q_temp[7:0];
			d_temp[15:8] <= (byteena[1]) ? d[15:8] : q_temp[15:8];
			q_temp <= d_temp;
		end
	end

	assign q = q_temp;

endmodule
