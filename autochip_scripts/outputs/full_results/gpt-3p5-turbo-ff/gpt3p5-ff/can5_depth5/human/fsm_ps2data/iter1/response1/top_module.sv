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
	reg [23:0] out_bytes_reg;

	always @(posedge clk) begin
		if (reset) begin
			state <= 0;
			byte1 <= 0;
			byte2 <= 0;
			byte3 <= 0;
			out_bytes_reg <= 0;
		end else begin
			case (state)
				0: begin
					if (in[3]) begin
						state <= 1;
						byte1 <= in;
					end
				end
				1: begin
					state <= 2;
					byte2 <= in;
				end
				2: begin
					state <= 3;
					byte3 <= in;
				end
				3: begin
					state <= 0;
					out_bytes_reg <= {byte1, byte2, byte3};
				end
				default: state <= 0;
			endcase
		end
	end

	always @(out_bytes_reg) begin
		if (done) begin
			out_bytes <= out_bytes_reg;
		end else begin
			out_bytes <= 0;
		end
	end

	always @(state) begin
		if (state == 3) begin
			done <= 1;
		end else begin
			done <= 0;
		end
	end

endmodule
