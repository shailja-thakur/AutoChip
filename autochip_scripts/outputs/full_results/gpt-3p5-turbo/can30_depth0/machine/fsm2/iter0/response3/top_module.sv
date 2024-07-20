module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	
	reg [1:0] state;
	wire next_state;

	always_comb begin
		if (state == 2'b00) begin // State A
			if (j) begin
				next_state = 2'b01; // Transition to state B
			end
			else begin
				next_state = 2'b00; // Stay in state A
			end
		end
		else begin // State B
			if (k) begin
				next_state = 2'b00; // Transition to state A
			end
			else begin
				next_state = 2'b01; // Stay in state B
			end
		end
	end

	always_ff @(posedge clk, posedge areset) begin
		if (areset) begin
			state <= 2'b00; // Reset to state A
		end
		else begin
			state <= next_state; // Update state
		end
	end

	assign out = (state == 2'b01) ? 1'b1 : 1'b0; // Set out port based on current state
endmodule
