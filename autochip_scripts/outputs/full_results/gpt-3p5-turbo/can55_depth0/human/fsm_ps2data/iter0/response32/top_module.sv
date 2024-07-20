module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	// Register to hold the current state
	reg [1:0] state;
	
	// Registers to hold the received bytes
	reg [7:0] byte1;
	reg [7:0] byte2;
	reg [7:0] byte3;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= 0;
			byte1 <= 0;
			byte2 <= 0;
			byte3 <= 0;
			done <= 0;
			out_bytes <= 0;
		end else begin
			case (state)
				0: begin // Waiting for byte with in[3]=1
					if (in[3]) begin
						state <= 1;
						byte1 <= in;
					end
				end
				1: begin // Waiting for second byte
					state <= 2;
					byte2 <= in;
				end
				2: begin // Waiting for third byte
					state <= 0;
					byte3 <= in;
					done <= 1;
					out_bytes <= {byte1, byte2, byte3};
				end
				default: state <= 0;
			endcase
		end
	end
endmodule
