module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [2:0] state;
reg [7:0] byte_counter;

always @(posedge clk) begin
	if (reset) begin
		state <= 0;
		byte_counter <= 0;
		out_bytes <= 0;
		done <= 0;
	end else begin
		case (state)
			0: begin // Idle state
				if (in[3]) begin
					state <= 1;
					byte_counter <= 0;
				end
			end
			
			1: begin // Byte 1 state
				state <= 2;
				out_bytes[23:16] <= in;
			end
			
			2: begin // Byte 2 state
				state <= 3;
				out_bytes[15:8] <= in;
			end
			
			3: begin // Byte 3 state
				state <= 0;
				out_bytes[7:0] <= in;
				done <= 1;
			end
		endcase
	end
end

endmodule
