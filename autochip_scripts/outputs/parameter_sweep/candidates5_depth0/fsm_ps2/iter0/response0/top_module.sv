module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [7:0] byte1;
reg [7:0] byte2;
reg [7:0] byte3;

reg [2:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		byte1 <= 0;
		byte2 <= 0;
		byte3 <= 0;
		done <= 0;
	end
	else begin
		case (state)
			0: begin
				// Discard bytes until in[3] equals 1
				if (in[3] == 1)
					state <= 1;
			end
			1: begin
				// Save first byte
				byte1 <= in;
				state <= 2;
			end
			2: begin
				// Save second byte
				byte2 <= in;
				state <= 3;
			end
			3: begin
				// Save third byte
				byte3 <= in;
				state <= 0;
				done <= 1;
			end
		endcase
	end
end

endmodule
