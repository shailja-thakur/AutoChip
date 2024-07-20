module top_module (
	input clk,
	input in,
	input areset,
	output out
);
 
	reg [1:0] state, next_state;
	// Define the states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
 
	// Define the outputs
	parameter OUTPUT_0 = 1'b0;
	parameter OUTPUT_1 = 1'b1;

	// Register to hold the output
	reg output_reg;
	
	// Output assignment
	always @(state)
		begin
			case(state)
				A: output_reg = OUTPUT_0;
				D: output_reg = OUTPUT_1;
				default: output_reg = OUTPUT_0;
			endcase
		end
	
	// Moore state machine logic
	always @(posedge clk or posedge areset)
		begin
			if(areset)
				state <= A;
			else
				state <= next_state;
		end
	
	// State transition logic
	always @(state, in)
		begin
			case(state)
				A:
					begin
						if(in == 1'b0)
							next_state = A;
						else if(in == 1'b1)
							next_state = B;
					end
				B:
					begin
						if(in == 1'b0)
							next_state = C;
						else if(in == 1'b1)
							next_state = B;
					end
				C:
					begin
						if(in == 1'b0)
							next_state = A;
						else if(in == 1'b1)
							next_state = D;
					end
				D:
					begin
						if(in == 1'b0)
							next_state = C;
						else if(in == 1'b1)
							next_state = B;
					end
				default:
					next_state = A;
			endcase
		end

	// Output assignment
	assign out = output_reg;
	
endmodule
