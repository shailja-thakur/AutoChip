module top_module (
	input clk,
	input in,
	input reset,
	output out
);

	// Define the states 
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;

	reg [1:0] current_state;
	reg [1:0] next_state;
	reg out_reg;

	// Assign initial state
	always @ (posedge clk or posedge reset)
	begin
		if (reset)
			current_state <= A;
		else
			current_state <= next_state;
	end
  
	// Define the Moore state machine
	always @ (*)
	begin
		// Default values for next state and output
		next_state = current_state;
		out_reg = 0;
    
		// State transition logic
		case (current_state)
			A: begin
				if (in)
					next_state = B;
				else
					next_state = A;
				out_reg = 0;
			end
      
			B: begin
				if (in)
					next_state = B;
				else
					next_state = C;
				out_reg = 0;
			end
      
			C: begin
				if (in)
					next_state = D;
				else
					next_state = A;
				out_reg = 0;
			end
      
			D: begin
				if (in)
					next_state = B;
				else
					next_state = C;
				out_reg = 1;
			end
		endcase
	end
  
	// Assign the outputs
	always @ (posedge clk)
	begin
		out <= out_reg;
	end

endmodule
