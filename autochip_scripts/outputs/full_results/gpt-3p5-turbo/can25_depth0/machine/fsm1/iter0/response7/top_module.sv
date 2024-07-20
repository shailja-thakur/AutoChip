module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state;
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b01; // Reset to state B
		else if (state == 2'b00) begin // State A
			if (in)
				state <= state; // Next state is A
			else
				state <= 2'b01; // Next state is B
		end else begin // State B
			if (in)
				state <= 2'b11; // Next state is B
			else
				state <= 2'b00; // Next state is A
		end
	end

	assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Output is high when state is B, low otherwise

endmodule
