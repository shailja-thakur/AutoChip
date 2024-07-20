module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

	reg [1:0] state;
	reg [7:0] buffer [2:0];

	always @(posedge clk) begin
		if (reset) begin
			state <= 0;
			buffer[0] <= 0;
			buffer[1] <= 0;
			buffer[2] <= 0;
			out_bytes <= 0;
			done <= 0;
		end else begin
			case (state)
				0: begin
					if (in[3] == 1) begin
						state <= 1;
						buffer[0] <= in;
					end
				end
				1: begin
					state <= 2;
					buffer[1] <= in;
				end
				2: begin
					state <= 3;
					buffer[2] <= in;
				end
				3: begin
					state <= 0;
					out_bytes <= {buffer[2], buffer[1], buffer[0]};
					done <= 1;
				end
				default: state <= 0;
			endcase
		end
	end

endmodule
