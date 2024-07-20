module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	// Declare state variables
	reg [1:0] state;
	reg [1:0] next_state;
	
	// Assign initial state
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b0;  // Set initial state to B
		end else begin
			state <= next_state;
		end
	end
	
	// Determine next state based on input and current state
	always @(*) begin
		case (state)
			2'b00: begin  // State A
				if (in) begin
					next_state = 2'b00;  // Next state: A
				end else begin
					next_state = 2'b01;  // Next state: B
				end
			end
			
			2'b01: begin  // State B
				if (in) begin
					next_state = 2'b01;  // Next state: B
				end else begin
					next_state = 2'b00;  // Next state: A
				end
			end
		endcase
	end
	
	// Output assignment
	assign out = (state == 2'b01) ? 1'b1 : 1'b0;
	
endmodule
