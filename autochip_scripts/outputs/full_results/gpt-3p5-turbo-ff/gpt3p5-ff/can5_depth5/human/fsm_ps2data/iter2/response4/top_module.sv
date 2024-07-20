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
	reg [1:0] count;
	reg [23:0] out_bytes_reg;

	always @(posedge clk) begin
		if (reset) begin
			state <= 0;
			byte1 <= 0;
			byte2 <= 0;
			byte3 <= 0;
			count <= 0;
			out_bytes_reg <= 0;
		end else begin
			case (state)
				0: begin
					if (in[3]) begin
						state <= 1;
						byte1 <= in;
						count <= 1;
					end
				end
				1: begin
					state <= 2;
					byte2 <= in;
					count <= 2;
				end
				2: begin
					state <= 3;
					byte3 <= in;
					count <= 3;
				end
				3: begin
					if (count == 3) begin
						state <= 0;
						out_bytes_reg <= {byte1, byte2, byte3};
						byte1 <= 0;
						byte2 <= 0;
						byte3 <= 0;
						count <= 0;
					end else begin
						count <= count + 1;
					end
				end
				default: state <= 0;
			endcase
		end
	end

	assign out_bytes = out_bytes_reg;
	assign done = (state == 3);

endmodule
