module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Declare state register
	reg [2:0] state;
	
	// Declare next_state register
	reg [2:0] next_state;
	
	// Register for output z
	reg z_reg;
	
	// Assign value to output z
	assign z = z_reg;
	
	// Synchronous reset
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= 3'b000;  // Initial state is A
		else
			state <= next_state;
	end
	
	// State transition logic
	always @(state, w)
	begin
		case(state)
			3'b000:  // State A
			begin
				if (w)
					next_state = 3'b001;  // Next state is B
				else
					next_state = 3'b000;  // Next state is A
			end
			
			3'b001:  // State B
			begin
				if (w)
					next_state = 3'b010;  // Next state is C
				else
					next_state = 3'b010;  // Next state is D
			end
			
			3'b010:  // State C
			begin
				if (w)
					next_state = 3'b101;  // Next state is E
				else
					next_state = 3'b010;  // Next state is D
			end
			
			3'b011:  // State D
			begin
				if (w)
					next_state = 3'b111;  // Next state is F
				else
					next_state = 3'b000;  // Next state is A
			end
			
			3'b101:  // State E
			begin
				if (w)
					next_state = 3'b101;  // Next state is E
				else
					next_state = 3'b010;  // Next state is D
			end
			
			3'b110:  // State F
			begin
				if (w)
					next_state = 3'b011;  // Next state is C
				else
					next_state = 3'b010;  // Next state is D
			end
		endcase
	end
	
	// Set output z based on state E or F
	always @(state)
	begin
		if (state == 3'b101 || state == 3'b110)
			z_reg = 1'b1;
		else
			z_reg = 1'b0;
	end
	
endmodule
