module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [7:0] byte0;
	reg [7:0] byte1;
	reg [7:0] byte2;
	reg [23:0] output_bytes;
	reg done_reg;
	
	always @(posedge clk) begin
		if (reset) begin
			byte0 <= 8'b0;
			byte1 <= 8'b0;
			byte2 <= 8'b0;
			done_reg <= 1'b0;
			output_bytes <= 24'b0;
		end else begin
			byte0 <= byte1;
			byte1 <= byte2;
			byte2 <= in;
			
			if (done_reg) begin
				done_reg <= 1'b0;
				output_bytes <= 24'b0;
			end else if (byte0[3] && !byte1[3] && !byte2[3]) begin
				output_bytes[23:16] <= byte0;
				output_bytes[15:8] <= byte1;
				output_bytes[7:0] <= byte2;
				done_reg <= 1'b1;
			end
		end
	end
	
	assign out_bytes = output_bytes;
	assign done = done_reg;
	
endmodule
