module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] byte_cnt;
reg previous_in3;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		byte_cnt <= 0;
		previous_in3 <= 0;
		done <= 0;
	end else begin
		case(state)
			0: begin // Idle state
				if (in[3] == 1) begin
					state <= 1;
				end
			end
			1: begin // Byte 1
				if (byte_cnt < 2) begin
					if (in[3] == 1) begin
						byte_cnt <= byte_cnt + 1;
						state <= 1;
					end else begin
						state <= 0;
					end
				end else begin
					if (in[3] == 1) begin
						byte_cnt <= 0;
						state <= 2;
					end else begin
						state <= 0;
					end
				end
			end
			2: begin // Byte 2
				if (byte_cnt < 2) begin
					if (in[3] == 1) begin
						byte_cnt <= byte_cnt + 1;
						state <= 2;
					end else begin
						state <= 0;
					end
				end else begin
					if (in[3] == 1) begin
						byte_cnt <= 0;
						state <= 3;
						done <= 1;
					end else begin
						state <= 0;
					end
				end
			end
			3: begin // Byte 3
				state <= 0;
			end
		endcase
	end
end

endmodule
