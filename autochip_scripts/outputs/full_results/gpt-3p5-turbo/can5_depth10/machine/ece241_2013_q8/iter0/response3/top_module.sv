module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	reg [1:0] state, next_state; // Define state and next_state as 2-bit registers

	always @(posedge clk or negedge aresetn) begin
		if (!aresetn) begin
			state <= 2'b0; // Reset state to 0 when aresetn is low
			z <= 1'b0; // Reset output z to 0 when aresetn is low
		end else begin
			state <= next_state; // Update state with next_state
			z <= (state == 2'b10) ? x : 1'b0; // Assign output z based on state and input x
		end
	end
	
	always @(*) begin
		case ({x, state}) // Combine input x and state to determine next_state
			2'b00_00: next_state = 2'b00; // When input x is 0 and state is S, next state is S
			2'b01_00: next_state = 2'b01; // When input x is 1 and state is S, next state is S1
			2'b00_01: next_state = 2'b10; // When input x is 0 and state is S1, next state is S10
			2'b01_01: next_state = 2'b01; // When input x is 1 and state is S1, next state is S1
			2'b00_10: next_state = 2'b00; // When input x is 0 and state is S10, next state is S
			2'b01_10: next_state = 2'b01; // When input x is 1 and state is S10, next state is S1
			default: next_state = 2'b00; // Set default next state as S
		endcase
	end
endmodule
