module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [23:0] out_reg;
reg [7:0] state;
reg done;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 0;
		out_reg <= 0;
		done <= 0;
	end else begin
		case (state)
			0: begin // BYTE1
				if (in[2] == 1'b1)
					state <= 1; // BYTE2
				else
					state <= 0; // BYTE1
				out_reg <= {out_reg[15:0], in};
			end
			1: begin // BYTE2
				if (in[2] == 1'b1)
					state <= 2; // BYTE3
				else
					state <= 0; // BYTE1
				out_reg <= {out_reg[15:0], in};
			end
			2: begin // BYTE3
				if (in[2] == 1'b1)
					state <= 3; // DONE
				else
					state <= 1; // BYTE2
				out_reg <= {out_reg[15:0], in};
			end
			3: begin // DONE
				if (in[2] == 1'b1)
					state <= 3; // DONE
				else
					state <= 0; // BYTE1
				out_reg <= {out_reg[15:0], in};
			end
			default: begin
				state <= 0;
				out_reg <= 0;
			end
		endcase
	end
end

assign out_bytes = done ? out_reg : 0;
assign done = (state == 3);

endmodule
