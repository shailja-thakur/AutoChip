module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	// Define states
	typedef enum logic[1:0] {
		A, 
		B
	} state_t;
	
	// Define next state logic
	state_t curr_state;
	state_t next_state;
	
	// Define output logic
	logic out;
	
	// Define state register
	always_ff @(posedge clk, posedge areset)
	begin
		if (areset)
			curr_state <= A;
		else
			curr_state <= next_state;
	end
	
	// Define next state and output logic
	always_comb
	begin
		case (curr_state)
			A: begin
				if (x)
				begin
					next_state = B;
					out = 1;
				end
				else
				begin
					next_state = A;
					out = 0;
				end
			end
			
			B: begin
				if (x)
				begin
					next_state = B;
					out = 0;
				end
				else
				begin
					next_state = B;
					out = 1;
				end
			end
		endcase
	end
	
	// Assign output
	assign z = out;
	
endmodule
