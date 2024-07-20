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
	reg [23:0] message;
	reg done_int;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			byte1 <= 8'b0;
			byte2 <= 8'b0;
			byte3 <= 8'b0;
			message <= 24'b0;
			done_int <= 1'b0;
		end else begin
			if (done_int) begin
				byte1 <= in;
				byte2 <= 8'b0;
				byte3 <= 8'b0;
				message <= {in, byte2, byte3};
				done_int <= 1'b0;
			end else if (byte1 == 8'b0 && in[3] == 1'b1) begin
				byte1 <= in;
				byte2 <= 8'b0;
				byte3 <= 8'b0;
				message <= {in, byte2, byte3};
				done_int <= 1'b0;
			end else if (byte1 != 8'b0 && byte2 == 8'b0) begin
				byte2 <= in;
				message <= {byte1, in, byte3};
				done_int <= 1'b0;
			end else if (byte1 != 8'b0 && byte2 != 8'b0 && byte3 == 8'b0) begin
				byte3 <= in;
				message <= {byte1, byte2, in};
				done_int <= 1'b1;
			end
		end
	end

	assign out_bytes = message;
	assign done = done_int;

endmodule
