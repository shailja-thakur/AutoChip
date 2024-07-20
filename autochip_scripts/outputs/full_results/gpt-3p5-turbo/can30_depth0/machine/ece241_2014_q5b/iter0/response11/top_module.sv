module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	reg [1:0] state;

	always @(posedge clk or negedge areset) begin
		if (areset == 0)
			state <= 2'b00; // State A
		else
			case(state)
				2'b00: if (x == 1) state <= 2'b01; // State B
				default: state <= state;
			endcase
	end

	assign z = (state == 2'b00 && x == 1) || (state == 2'b01 && x == 0) ? 1 : 0;

endmodule
