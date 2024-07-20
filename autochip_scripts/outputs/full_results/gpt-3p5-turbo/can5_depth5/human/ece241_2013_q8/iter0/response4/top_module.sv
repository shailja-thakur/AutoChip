module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	// Declare the states
	parameter S0 = 2'b00;
	parameter S1 = 2'b01;
	parameter S2 = 2'b10;
	
	// Declare the current state and next state variables
	reg [1:0] state, next_state;
	
	// Declare the output enable variable
	wire oe;
	
	// Declare the output reg
	reg o_reg;
	
	// State transition logic
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S0;
		end
		else begin
			state <= next_state;
		end
	end
	
	// Combinational logic
	always @(state or x) begin
		case (state)
			S0: begin
				if (x == 1'b1) begin
					next_state = S1;
				end
				else begin
					next_state = S0;
				end
			end
			S1: begin
				if (x == 1'b0) begin
					next_state = S2;
				end
				else begin
					next_state = S0;
				end
			end
			S2: begin
				if (x == 1'b1) begin
					next_state = S1;
				end
				else begin
					next_state = S0;
				end
			end
			default: next_state = S0;
		endcase
	end
	
	// Output logic
	always @(state or x) begin
		if (state == S2) begin
			o_reg = 1'b1;
		end
		else begin
			o_reg = 1'b0;
		end
	end
	
	// Assign outputs
	assign z = o_reg;
	assign oe = 1'b1; // Enable output
	
endmodule
