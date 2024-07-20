module top_module(
	input clk,
	input resetn,
	input [1:0] byteena,
	input [15:0] d,
	output reg [15:0] q);

	reg [7:0] lower_byte;
	reg [7:0] upper_byte;

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			// reset all flip-flops
			lower_byte <= 8'b0;
			upper_byte <= 8'b0;
		end else begin
			// update flip-flops based on byte enable signals
			if (byteena[0]) begin
				lower_byte <= d[7:0];
			end
			if (byteena[1]) begin
				upper_byte <= d[15:8];
			end
		end
	end

	always @(posedge clk or negedge resetn) begin
		if (!resetn) begin
			// reset output
			q <= 16'b0;
		end else begin
			// update output based on flip-flop values
			q <= {upper_byte, lower_byte};
		end
	end
endmodule
