module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output done
);

reg [2:0] state;
reg [7:0] byte_count;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		byte_count <= 0;
		done <= 0;
	end else begin
		case (state)
			0: begin // State 0 - Searching for start of message
				if (in[3] == 1) begin
					state <= 1;
					byte_count <= 1;
				end
			end
			1: begin // State 1 - Receiving first byte of message
				if (byte_count == 3) begin
					state <= 2;
					byte_count <= 0;
					done <= 1;
				end else begin
					byte_count <= byte_count + 1;
				end
			end
			2: begin // State 2 - Receiving second byte of message
				if (byte_count == 3) begin
					state <= 3;
					byte_count <= 0;
				end else begin
					byte_count <= byte_count + 1;
				end
			end
			3: begin // State 3 - Receiving third byte of message
				if (byte_count == 3) begin
					state <= 0;
					byte_count <= 0;
				end else begin
					byte_count <= byte_count + 1;
				end
			end
		endcase
	end
end

endmodule
