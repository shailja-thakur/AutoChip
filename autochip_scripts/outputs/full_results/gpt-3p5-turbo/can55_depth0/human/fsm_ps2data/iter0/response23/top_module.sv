module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [2:0] state;
	reg [7:0] byte2;
	reg [7:0] byte1;
	reg [7:0] byte0;

	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= 0;
			byte2 <= 0;
			byte1 <= 0;
			byte0 <= 0;
			done <= 0;
			out_bytes <= 0;
		end else begin
			case (state)
				0: begin
					byte2 <= in;
					state <= (in[3] == 1) ? 1 : 0;
				end
				1: begin
					byte1 <= in;
					state <= 2;
				end
				2: begin
					byte0 <= in;
					state <= 3;
				end
				3: begin
					byte2 <= in;
					state <= (in[3] == 1) ? 1 : 0;
					out_bytes <= {byte2, byte1, byte0};
					done <= 1;
				end
				default: begin
					state <= 0;
				end
			endcase
		end
	end	   

endmodule
