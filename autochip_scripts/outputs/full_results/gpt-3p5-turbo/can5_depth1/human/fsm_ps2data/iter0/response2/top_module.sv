module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [1:0] state;
	reg [7:0] byte1;
	reg [7:0] byte2;
	reg [7:0] byte3;

	always @(posedge clk) begin
		if (reset) begin
			state <= 2'b00;
			byte1 <= 0;
			byte2 <= 0;
			byte3 <= 0;
			done <= 0;
		end else begin
			case (state)
				2'b00: begin
					if (in[3]) begin
						state <= 2'b01;
						byte1 <= in;
					end
				end
				2'b01: begin
					state <= 2'b10;
					byte2 <= in;
				end
				2'b10: begin
					state <= 2'b11;
					byte3 <= in;
				end
				2'b11: begin
					state <= 2'b00;
					done <= 1;
					out_bytes <= {byte1, byte2, byte3};
				end
			endcase
		end
	end

endmodule
