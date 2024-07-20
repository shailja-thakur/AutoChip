module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output reg done
);

	reg [23:0] out_reg;
	reg [1:0] state;
	assign out_bytes = done ? out_reg : 0;
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b00; // BYTE1 state
		else begin
			case(state)
				2'b00: begin // BYTE1 state
					if (in[2] == 1)
						state <= 2'b01; // BYTE2 state
					else
						state <= 2'b00; // Loop back to BYTE1 state
					out_reg <= {out_reg[15:0], in};
				end
				2'b01: begin // BYTE2 state
					if (in[2] == 1)
						state <= 2'b10; // BYTE3 state
					else
						state <= 2'b00; // Back to BYTE1 state
					out_reg <= {out_reg[15:0], in};
				end
				2'b10: begin // BYTE3 state
					state <= 2'b11; // DONE state
					out_reg <= {out_reg[15:0], in};
				end
				2'b11: begin // DONE state
					if (in[2] == 0)
						state <= 2'b00; // Back to BYTE1 state
					else
						state <= 2'b11; // Stay in DONE state
					out_reg <= {out_reg[15:0], in};
				end
			endcase
		end
	end
	
	always @(posedge clk or posedge reset) begin
		if (reset)
			done <= 0;
		else if (state == 2'b11)
			done <= 1;
		else
			done <= 0;
	end
	
endmodule
