module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [7:0] byte1, byte2, byte3;
	reg [2:0] state;

	always @(posedge clk) begin
		if (reset) begin
			state <= 0;
		end
		else begin
			case(state)
				0: begin // Look for byte1
					if (in[3]) begin
						byte1 <= in;
						state <= 1;
					end
				end
				1: begin // Look for byte2
					byte2 <= in;
					state <= 2;
				end
				2: begin // Look for byte3
					byte3 <= in;
					state <= 3;
					done <= 1;
				end
				3: begin // Output message and reset
					out_bytes[23:16] <= byte1;
					out_bytes[15:8] <= byte2;
					out_bytes[7:0] <= byte3;
					done <= 0;
					state <= 0;
				end
			endcase
		end
	end
	
endmodule
