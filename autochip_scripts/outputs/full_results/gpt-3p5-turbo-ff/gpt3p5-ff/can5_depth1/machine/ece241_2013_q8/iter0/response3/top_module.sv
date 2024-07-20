module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Define states
	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;
	
	// Define signals
	reg [1:0] state, state_next;
	
	// State register
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			state <= state_next;
		end
	end
	
	// Next state logic
	always @* begin
		case ({x, state})
			2'b00: state_next = S;
			2'b01: state_next = S1;
			2'b10: state_next = S10;
			2'b11: state_next = S1;
		endcase
	end
	
	// Output logic
	always @* begin
		case (state)
			S: z = 1'b0;
			S1: z = 1'b0;
			S10: z = x;
		endcase
	end
	
endmodule
