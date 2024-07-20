module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);
	
// Define states
parameter S0 = 2'b00;  // Initial state
parameter S1 = 2'b01;  // State after 1
parameter S2 = 2'b10;  // State after 10

// Define current and next state variables
reg [1:0] current_state;
reg [1:0] next_state;

// Next state logic
always @(posedge clk or negedge aresetn) begin
	if (~aresetn) begin
		current_state <= S0;
	end else begin
		current_state <= next_state;
	end
end

// Output logic
always @(current_state or x) begin
	z <= 0;
	case (current_state)
		S0: if (x == 1'b1) next_state <= S1;
		S1: if (x == 1'b0) next_state <= S2;
		S2: if (x == 1'b1) begin
				next_state <= S1;
				z <= 1;
			end
	endcase
end

endmodule
