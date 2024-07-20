module top_module (
	input clk,
	input reset,
	input x,
	output reg z,
	output reg [2:0] y
);

	// define states
	parameter S0 = 3'b000;
	parameter S1 = 3'b001;
	parameter S2 = 3'b010;
	parameter S3 = 3'b011;
	parameter S4 = 3'b100;
	
	// create state register
	reg [2:0] current_state, next_state;
	
	// combinational logic for next state and output
	always @(current_state or x)
	begin
		case(current_state)
			
			S0: 
			begin
				if(x == 1'b0)
				begin
					next_state = S0;
					z = 1'b0;
				end
				else
				begin
					next_state = S1;
					z = 1'b0;
				end
			end
			
			S1: 
			begin
				if(x == 1'b0)
				begin
					next_state = S1;
					z = 1'b0;
				end
				else
				begin
					next_state = S4;
					z = 1'b0;
				end
			end
			
			S2: 
			begin
				if(x == 1'b0)
				begin
					next_state = S2;
					z = 1'b0;
				end
				else
				begin
					next_state = S1;
					z = 1'b0;
				end
			end
			
			S3: 
			begin
				if(x == 1'b0)
				begin
					next_state = S1;
					z = 1'b1;
				end
				else
				begin
					next_state = S2;
					z = 1'b0;
				end
			end
			
			S4: 
			begin
				if(x == 1'b0)
				begin
					next_state = S3;
					z = 1'b1;
				end
				else
				begin
					next_state = S4;
					z = 1'b1;
				end
			end
			
		endcase
	end

	// sequential logic for state update
	always @(posedge clk, posedge reset)
	begin
		if(reset)
			current_state <= S0;
		else
			current_state <= next_state;
	end
	
	// assign output to module output
	assign y = current_state;
	
endmodule
