module top_module (
	input clk,
	input in,
	input areset,
	output out
);

reg [1:0] state;
reg out_reg;

always @(posedge clk or posedge areset) begin
	if(areset) begin
		state <= 2'b10; // Reset state to B
		out_reg <= 1'b1;
	end else begin
		case(state)
			2'b00: begin // State is A
				state <= (in == 1'b1) ? 2'b00 : 2'b01;
			end
			2'b01: begin // State is B
				state <= (in == 1'b1) ? 2'b01 : 2'b00;
			end
			default: begin
				state <= 2'b10; // Reset state to B
			end
		endcase

		out_reg <= (state == 2'b01) ? 1'b0 : 1'b1; // Output is high when state is B
	end
end

assign out = out_reg;

endmodule
