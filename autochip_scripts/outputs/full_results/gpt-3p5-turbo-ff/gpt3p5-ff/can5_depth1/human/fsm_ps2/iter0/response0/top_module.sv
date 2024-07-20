module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

	reg [2:0] state;
	reg [7:0] byte1;
	reg [7:0] byte2;
	reg [7:0] byte3;

	always @(posedge clk) begin
		if (reset) begin
			state <= 0;
			byte1 <= 8'h00;
			byte2 <= 8'h00;
			byte3 <= 8'h00;
			done <= 0;
		end else begin
			case (state)
				0: begin // Wait for byte1 with in[3] = 1
					if (in[3] == 1)
						state <= 1;
				end
				1: begin // byte1 received, wait for byte2
					byte1 <= in;
					state <= 2;
				end
				2: begin // byte1 and byte2 received, wait for byte3
					byte2 <= in;
					state <= 3;
				end
				3: begin // byte1, byte2, and byte3 received, output done
					byte3 <= in;
					state <= 0;
					done <= 1;
				end
			endcase
		end
	end

endmodule
