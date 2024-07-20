module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	reg [1:0] state;
	always_comb begin
		if (state == 2'b00 && j) begin
			state = 2'b01; // Transition from state A to state B
		end else if (state == 2'b01 && k) begin
			state = 2'b00; // Transition from state B to state A
		end
	end

	always_ff @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00; // Reset the FSM to state A
		end else begin
			state <= state; // Update the state based on the next state
		end
	end

	assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Set out based on the current state

endmodule
