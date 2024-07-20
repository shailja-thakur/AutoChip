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
	reg done_prev;

	always @(posedge clk) begin
		if (reset) begin
			done_prev <= 0;
			byte1 <= 0;
			byte2 <= 0;
			byte3 <= 0;
			message <= 0;
			done <= 0;
		end else begin
			byte1 <= in;
			byte2 <= byte1;
			byte3 <= byte2;
			message <= {message[15:0], byte1};
			done_prev <= done;
			done <= (byte3[3] && !done_prev);
		end
	end

	assign out_bytes = message;

endmodule
