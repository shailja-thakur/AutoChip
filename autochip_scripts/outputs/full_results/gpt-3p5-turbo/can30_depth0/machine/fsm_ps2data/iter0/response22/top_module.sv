module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output reg [23:0] out_bytes,
	output reg done
);

reg [3:0] state;
reg [23:0] shift_reg;

always @(posedge clk or posedge reset) begin
	if (reset)
		state <= BYTE1;
	else begin
		case(state)
			BYTE1:
				if (in[2] == 1)
					state <= BYTE2;
				else
					state <= BYTE1;
			BYTE2:
				if (in[2] == 1)
					state <= BYTE3;
				else
					state <= BYTE1;
			BYTE3:
				if (in[2] == 1)
					state <= DONE;
				else
					state <= BYTE1;
			DONE:
				if (in[2] == 0)
					state <= BYTE1;
				else
					state <= DONE;
		endcase
	end

	case(state)
		BYTE1:
			shift_reg <= {in, shift_reg[23:8]};
		BYTE2:
			shift_reg <= {in, shift_reg[23:8]};
		BYTE3:
			shift_reg <= {in, shift_reg[23:8]};
		DONE:
			shift_reg <= shift_reg;
	endcase

	out_bytes <= (done == 1) ? shift_reg : 24'b0;
	done <= (state == DONE) ? 1'b1 : 1'b0;

end

endmodule
