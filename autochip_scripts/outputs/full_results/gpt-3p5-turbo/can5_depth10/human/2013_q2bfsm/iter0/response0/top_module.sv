module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);
	
	// Define the states of the FSM
	typedef enum logic [1:0] {
		A,       // Beginning state
		B,       // Waiting for clock edge after reset de-assertion
		C,       // Waiting for x = 1, 0, 1
		D,       // Waiting for y = 1 or y != 1 within 2 clock cycles
		E        // Setting g = 0 permanently
	} fsm_state;
	
	// Declare the current state variable
	reg fsm_state current_state;
	
	// Declare the next state variable
	reg fsm_state next_state;
		
	// FSM outputs
	reg f;
	reg g;
	
	// FSM state registers
	reg [2:0] x_reg;   // Keeps track of past x values
	reg [1:0] y_reg;   // Keeps track of past y values
	
	// Assign initial state
	always @(*) begin
		if (!resetn)		// Asserted reset
			current_state = A;
		else
			current_state = next_state;
	end
	
	// Declare various signals needed for FSM logic
	reg reset_next_state;
	reg clk_edge_event;
	reg x_valid;
	
	// Detect reset de-assertion
	always @(posedge clk, negedge resetn)
		reset_next_state <= !resetn;
	
	// Detect clock edge event
	always @(posedge clk)
		clk_edge_event <= 1;
	
	// Detect if x has produced 1, 0, 1 in three successive clock cycles
	always @(posedge clk)
		x_valid <= (x_reg == 3'b101);
	
	// FSM logic
	always @(posedge clk) begin
		// Update current state
		current_state <= next_state;
		
		// Set next state based on current state
		case (current_state)
			A: begin
				if (reset_next_state)
					next_state = A;
				else
					next_state = B;
			end
			B: begin
				if (clk_edge_event)
					next_state = C;
				else
					next_state = B;
			end
			C: begin
				if (x_valid)
					next_state = D;
				else if (reset_next_state)
					next_state = A;
				else
					next_state = C;
			end
			D: begin
				if (y == 1)
					next_state = D;
				else if (y != 1 && y_reg == 2'b11)
					next_state = E;
				else if (reset_next_state)
					next_state = A;
				else
					next_state = D;
			end
			E: begin
				if (reset_next_state)
					next_state = A;
				else
					next_state = E;
			end
			default: next_state = A;
		endcase
		
		// Update outputs based on current state
		case (current_state)
			A: begin
				f = 0;
				g = 0;
			end
			B: begin
				f = 1;
				g = 0;
			end
			C: begin
				f = 0;
				g = 0;
			end
			D: begin
				f = 0;
				g = 1;
			end
			E: begin
				f = 0;
				g = 0;
			end
			default: begin
				f = 0;
				g = 0;
			end
		endcase
	end
	
	// Update x_reg and y_reg
	always @(posedge clk) begin
		x_reg <= {x_reg[1:0], x};
		y_reg <= {y_reg[0], y};
	end
	
endmodule
