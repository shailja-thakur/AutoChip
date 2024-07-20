module top_module (
	input clk,
	input [7:0] in,
	input reset,
	output [23:0] out_bytes,
	output done
);

reg [7:0] shift_reg;
reg [23:0] out_reg;
reg [1:0] state;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		shift_reg <= 0;
		out_reg <= 0;
		state <= 0;
	end else begin
		case (state)
			0: begin // BYTE1
				if (in[2] == 1'b1)
					state <= 1; // BYTE2
				else
					state <= 0; // BYTE1
			end
			1: begin // BYTE2
				state <= 2; // BYTE3
			end
			2: begin // BYTE3
				state <= 3; // DONE
			end
			3: begin // DONE
				if (in[2] == 1'b0)
					state <= 0; // BYTE1
				else
					state <= 3; // DONE
			end
			default: state <= 0; // BYTE1
		endcase

		if (state == 3) begin // DONE
			out_reg <= shift_reg;
		end

		shift_reg <= {shift_reg[15:0], in};
	end
end

assign out_bytes = out_reg;
assign done = (state == 3);

endmodule
