module top_module (
	input clk,
	input reset,
	input [7:0] in,
	output [23:0] out_bytes,
	output done
);

	reg [23:0] out_reg;
	reg [2:0] state;

	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= BYTE1;
		else begin
			case (state)
				BYTE1: begin
					if (in[2] == 1)
						state <= BYTE2;
					else
						state <= BYTE1;
				end
				BYTE2: begin
					state <= BYTE3;
				end
				BYTE3: begin
					state <= DONE;
				end
				DONE: begin
					if (in[2] == 0)
						state <= BYTE1;
					else
						state <= DONE;
				end
				default: begin
					state <= BYTE1;
				end
			endcase
		end
	end

	always @(posedge clk) begin
		if (reset)
			out_reg <= 0;
		else if (state == DONE)
			out_reg <= {in, in};
		else
			out_reg <= {out_reg[15:0], in};
	end

	assign out_bytes = out_reg;
	assign done = (state == DONE);

endmodule
