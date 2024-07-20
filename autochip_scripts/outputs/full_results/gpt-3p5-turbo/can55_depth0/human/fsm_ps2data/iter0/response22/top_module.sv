module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [7:0] byte_1;
	reg [7:0] byte_2;
	reg [7:0] byte_3;
	reg done_reg;

	always @(posedge clk or posedge reset) begin
		if(reset) begin
			byte_1 <= 8'd0;
			byte_2 <= 8'd0;
			byte_3 <= 8'd0;
			done_reg <= 1'b0;
		end else begin
			if(done_reg) begin
				byte_1 <= in;
				byte_2 <= 8'd0;
				byte_3 <= 8'd0;
				done_reg <= 1'b0;
			end else if(byte_1[3] & ~byte_2[3] & ~byte_3[3]) begin
				byte_2 <= in;
			end else begin
				byte_3 <= in;
				done_reg <= 1'b1;
			end
		end
	end

	assign out_bytes = {byte_1, byte_2, byte_3};
	assign done = done_reg;

endmodule
