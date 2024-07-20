module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);
	
	reg [2:0] state;
	reg [7:0] byte_1;
	reg [7:0] byte_2;
	reg [7:0] byte_3;
	
	always @(posedge clk) begin
		if (reset) begin
			state <= 0;
			byte_1 <= 0;
			byte_2 <= 0;
			byte_3 <= 0;
		end else begin
			case (state)
				0: begin // Discard bytes
					if (in[3] == 1) begin
						state <= 1;
						byte_1 <= in;
					end else begin
						state <= 0;
					end
				end
				1: begin // Receive byte 2
					state <= 2;
					byte_2 <= in;
				end
				2: begin // Receive byte 3
					state <= 3;
					byte_3 <= in;
				end
				3: begin // Done
					state <= 0;
					byte_1 <= 0;
					byte_2 <= 0;
					byte_3 <= 0;
				end
			endcase
		end
	end
	
	assign out_bytes[23:16] = byte_1;
	assign out_bytes[15:8] = byte_2;
	assign out_bytes[7:0] = byte_3;
	assign done = (state == 3);
	
endmodule
