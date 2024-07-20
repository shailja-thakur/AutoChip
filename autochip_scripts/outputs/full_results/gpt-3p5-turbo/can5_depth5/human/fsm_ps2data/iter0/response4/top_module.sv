module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [7:0] byte1 = 8'd0;
reg [7:0] byte2 = 8'd0;
reg [7:0] byte3 = 8'd0;
reg [23:0] message = 24'd0;

always @(posedge clk) begin
	if (reset) begin
		byte1 <= 8'd0;
		byte2 <= 8'd0;
		byte3 <= 8'd0;
		message <= 24'd0;
		done <= 0;
	end else if (in[3]) begin
		byte1 <= in;
		byte2 <= 8'd0;
		byte3 <= 8'd0;
		if (byte1 != 8'd0) begin
			message <= (byte1 << 16) | (byte2 << 8) | byte3;
			done <= 0;
		end
	end else if (byte1 != 8'd0) begin
		byte2 <= in;
		byte3 <= 8'd0;
		if (byte2 != 8'd0) begin
			message <= (byte1 << 16) | (byte2 << 8) | byte3;
			done <= 0;
		end
	end else if (byte2 != 8'd0) begin
		byte3 <= in;
		if (byte3 != 8'd0) begin
			message <= (byte1 << 16) | (byte2 << 8) | byte3;
			done <= 1;
		end
	end
end

assign out_bytes = message;

endmodule
