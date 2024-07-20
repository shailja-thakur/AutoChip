module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [23:0] shift_reg;
reg [1:0] state;

always @(posedge clk) begin
	if (reset) begin
		shift_reg <= 0;
		state <= 0;
	end else begin
		case(state)
			0: begin  // BYTE1 state
				if (in[2] == 1) begin
					shift_reg <= {shift_reg[15:0], in};
					state <= 1;
				end else begin
					shift_reg <= shift_reg << 8;
					state <= 0;
				end
			end
			1: begin  // BYTE2 state
				if (in[2] == 1) begin
					shift_reg <= {shift_reg[15:0], in};
					state <= 2;
				end else begin
					shift_reg <= shift_reg << 8;
					state <= 0;
				end
			end
			2: begin  // BYTE3 state
				shift_reg <= {shift_reg[15:0], in};
				state <= 3;
			end
			3: begin  // DONE state
				shift_reg <= shift_reg << 8;
				state <= 0;
			end
		endcase
	end
end

assign done = (state == 3);
assign out_bytes = (done) ? shift_reg : 0;

endmodule
