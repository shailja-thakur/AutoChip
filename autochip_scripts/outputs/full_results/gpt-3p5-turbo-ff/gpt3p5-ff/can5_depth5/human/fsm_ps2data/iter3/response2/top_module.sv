module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

	reg [1:0] state;
	reg [23:0] out_bytes_reg;
	reg [7:0] byte1;
	reg [7:0] byte2;
	reg [7:0] byte3;

	always @(posedge clk) begin
		if (reset) begin
			state <= 0;
			out_bytes_reg <= 0;
			byte1 <= 0;
			byte2 <= 0;
			byte3 <= 0;
		end else begin
			case(state)
				0: begin
					if (in[3]) begin
						state <= 1;
						byte1 <= in;
					end
				end
				1: begin
					byte2 <= in;
					state <= 2;
				end
				2: begin
					byte3 <= in;
					state <= 3;
				end
				3: begin
					state <= 0;
					out_bytes_reg <= {byte1, byte2, byte3};
					byte1 <= 0;
					byte2 <= 0;
					byte3 <= 0;
				end
			endcase
		end
	end

	assign out_bytes = out_bytes_reg;
	assign done = (state == 3);

endmodule
