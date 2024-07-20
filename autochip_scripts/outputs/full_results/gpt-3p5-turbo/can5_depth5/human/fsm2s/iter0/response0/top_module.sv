module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);

reg [1:0] state;
reg out_reg;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= 2'b0;
	end else begin
		case(state)
			2'b00: begin // OFF state
				if (j) begin
					state <= 2'b01; // Transition to ON state
				end else begin
					state <= 2'b00; // Stay in OFF state
				end
			end
			2'b01: begin // ON state
				if (k) begin
					state <= 2'b00; // Transition to OFF state
				end else begin
					state <= 2'b01; // Stay in ON state
				end
			end
			default: state <= 2'b00;
		endcase
	end
end

always @(posedge clk) begin
	if (state == 2'b01) begin
		out_reg <= 1'b1;
	else
		out_reg <= 1'b0;
	end
end

assign out = out_reg;

endmodule
