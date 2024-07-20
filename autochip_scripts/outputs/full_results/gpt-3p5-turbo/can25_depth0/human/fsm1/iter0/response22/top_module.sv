module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out_reg;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= 2'b10; // Reset to state B
	end else begin
		case (state)
			2'b00: begin
				if (in) begin
					state <= 2'b00; // Next state A
				end else begin
					state <= 2'b01; // Next state B
				end
			end
			2'b01: begin
				if (in) begin
					state <= 2'b00; // Next state A
				end else begin
					state <= 2'b01; // Next state B
				end
			end
			2'b10: begin
				state <= 2'b01; // Next state B
			end
			default: begin
				state <= 2'b10; // Reset to state B
			end
		endcase
	end
end

always @(state) begin
	case (state)
		2'b00: begin
			out_reg = 1'b0;
		end
		2'b01: begin
			out_reg = 1'b1;
		end
		default: begin
			out_reg = 1'b0;
		end
	endcase
end

assign out = out_reg;

endmodule
