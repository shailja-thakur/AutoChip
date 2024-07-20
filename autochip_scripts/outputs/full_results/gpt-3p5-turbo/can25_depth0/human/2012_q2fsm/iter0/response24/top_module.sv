module top_module (
	input clk,
	input reset,
	input w,
	output z
);

	// Create parameters for the state codes
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	// Create a reg variable for the FSM current state
	reg [1:0] state;
	
	// Create a reg variable for the next state
	reg [1:0] next_state;
	
	// Create the state flip-flop
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
	
	// Create the state table
	always @(state or w) begin
		case (state)
			A: begin
				if (w) begin
					next_state = B;
				end else begin
					next_state = A;
				end
			end
			
			B: begin
				if (w) begin
					next_state = C;
				end else begin
					next_state = D;
				end
			end
			
			C: begin
				if (w) begin
					next_state = E;
				end else begin
					next_state = D;
				end
			end
			
			D: begin
				if (w) begin
					next_state = F;
				end else begin
					next_state = A;
				end
			end
			
			E: begin
				if (w) begin
					next_state = E;
				end else begin
					next_state = D;
				end
			end
			
			F: begin
				if (w) begin
					next_state = C;
				end else begin
					next_state = D;
				end
			end
		endcase
	end
	
	// Assign output z based on state E and F
	always @(state) begin
		case (state)
			E: begin
				z = 1;
			end
			
			F: begin
				z = 1;
			end
			
			default: begin
				z = 0;
			end
		endcase
	end
endmodule
