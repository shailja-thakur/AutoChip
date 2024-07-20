module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] byte1, byte2, byte3;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		byte1 <= 0;
		byte2 <= 0;
		byte3 <= 0;
	end else begin
		case (state)
			0: begin // Wait for byte1
				if (in[3] == 1) begin
					byte1 <= in;
					state <= 1;
				end
			end
			1: begin // Wait for byte2
				byte2 <= in;
				state <= 2;
			end
			2: begin // Wait for byte3 and signal done
				byte3 <= in;
				state <= 0;
				done <= 1;
			end
		endcase
	end
end

endmodule
