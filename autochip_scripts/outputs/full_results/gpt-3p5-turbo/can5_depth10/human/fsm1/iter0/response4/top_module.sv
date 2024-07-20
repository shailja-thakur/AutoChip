module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	// Define states
	typedef enum logic [1:0] {A, B} state_type; 
	 
	// Define state register
	reg state_type current_state, next_state;
	 
	// Define output register
	reg out_reg;
	 
	always_ff @(posedge clk or negedge areset)
	begin
	    if (areset == 0)
	        current_state <= B;
	    else
	        current_state <= next_state;
	 
	    case (current_state)
	        A: begin
	            if (in == 0)
	                next_state = B;
	            else if (in == 1)
	                next_state = A;
	        end
	        
	        B: begin
	            if (in == 0)
	                next_state = A;
	            else if (in == 1)
	                next_state = B;
	        end
	    endcase
	end
	 
	always_comb
	begin
	    case (current_state)
	        A: out_reg = 0;
	        B: out_reg = 1;
	    endcase
	end
	 
	assign out = out_reg;
	 
endmodule
