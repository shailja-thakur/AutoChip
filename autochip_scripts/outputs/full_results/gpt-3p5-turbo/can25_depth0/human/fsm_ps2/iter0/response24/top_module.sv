module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);
	reg [2:0] state;
	reg [7:0] byte_cnt;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			byte_cnt <= 0;
			done <= 0;
		end else begin
			case(state)
				0: begin // Idle state
					if (in[3] == 1)
						state <= 1;
				end
				1: begin // Byte 1 state
					if (byte_cnt == 2) begin
						state <= 2;
						byte_cnt <= 0;
					end else begin
						state <= 1;
						byte_cnt <= byte_cnt + 1;
					end
				end
				2: begin // Byte 2 state
					if (byte_cnt == 2) begin
						state <= 3;
						byte_cnt <= 0;
					end else begin
						state <= 2;
						byte_cnt <= byte_cnt + 1;
					end
				end
				3: begin // Byte 3 state
					if (byte_cnt == 2) begin
						state <= 0;
						byte_cnt <= 0;
						done <= 1;
					end else begin
						state <= 3;
						byte_cnt <= byte_cnt + 1;
					end
				end
				default: state <= 0;
			endcase
		end
	end
endmodule
