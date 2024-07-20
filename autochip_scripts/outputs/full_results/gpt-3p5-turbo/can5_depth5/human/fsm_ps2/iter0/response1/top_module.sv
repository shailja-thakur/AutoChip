module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] byte_count;
reg done;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		byte_count <= 0;
		done <= 0;
	end else begin
		case (state)
			0: begin // Discard bytes until in[3] = 1
				if (in[3] == 1) begin
					state <= 1;
					byte_count <= 1;
				end
			end
			1: begin // Receive byte 1
				if (byte_count == 3) begin
					state <= 2;
				end else begin
					byte_count <= byte_count + 1;
				end
			end
			2: begin // Receive byte 2
				if (byte_count == 3) begin
					state <= 3;
				end else begin
					byte_count <= byte_count + 1;
				end
			end
			3: begin // Receive byte 3
				if (byte_count == 3) begin
					state <= 0;
					done <= 1;
				end else begin
					byte_count <= byte_count + 1;
				end
			end
		endcase
	end
end
endmodule
