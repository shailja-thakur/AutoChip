module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [7:0] byte1;
	reg [7:0] byte2;
	reg [7:0] byte3;
	reg [7:0] next_byte1;
	reg [7:0] next_byte2;
	reg [7:0] next_byte3;
	reg done_reg;
	wire done;

	always @(posedge clk, posedge reset) begin
		if (reset) begin
			byte1 <= 8'b0;
			byte2 <= 8'b0;
			byte3 <= 8'b0;
			done_reg <= 1'b0;
		end else begin
			byte1 <= next_byte1;
			byte2 <= next_byte2;
			byte3 <= next_byte3;
			done_reg <= (byte1[3] == 1'b1) && (byte2[3] == 1'b1) && (byte3[3] == 1'b1);
		end
	end

	always @(in or byte1 or byte2 or byte3 or done_reg) begin
		if (byte1[3] == 1'b1 && byte2[3] == 1'b0 && byte3[3] == 1'b0) begin
			next_byte1 = in;
			next_byte2 = byte1;
			next_byte3 = byte2;
		end else if (byte1[3] == 1'b0 && byte2[3] == 1'b1 && byte3[3] == 1'b0) begin
			next_byte1 = byte2;
			next_byte2 = in;
			next_byte3 = byte1;
		end else if (byte1[3] == 1'b0 && byte2[3] == 1'b0 && byte3[3] == 1'b1) begin
			next_byte1 = byte3;
			next_byte2 = byte1;
			next_byte3 = in;
		end else begin
			next_byte1 = byte1;
			next_byte2 = byte2;
			next_byte3 = byte3;
		end
	end

	assign done = done_reg;

	always @(posedge clk) begin
		if (done_reg) begin
			out_bytes[23:16] <= byte1; 
			out_bytes[15:8] <= byte2;
			out_bytes[7:0] <= byte3;
		end else begin
			out_bytes <= 24'b0;
		end
	end

endmodule
