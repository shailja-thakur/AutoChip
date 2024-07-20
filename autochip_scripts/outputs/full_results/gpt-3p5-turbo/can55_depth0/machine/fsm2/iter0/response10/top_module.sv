module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);

	// define the states
	typedef enum logic [1:0] {A, B} state_t;
	
	// define the signals
	reg state_t current_state;
	reg state_t next_state;
	
	// combinational always block for state transition
	always_comb begin
		if (current_state == A) begin
			next_state = (j == 1'b1) ? B : A;
		end else begin
			next_state = (k == 1'b1) ? A : B;
		end
	end
	
	// clocked always block for state update
	always_ff @(posedge clk) begin
		if (areset == 1'b1) begin
			current_state <= A;
		end else begin
			current_state <= next_state;
		end
	end
	
	// assign out port based on current state
	assign out = (current_state == B) ? 1'b1 : 1'b0;
	
endmodule
