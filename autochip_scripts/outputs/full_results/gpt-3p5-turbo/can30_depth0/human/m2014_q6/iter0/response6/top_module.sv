module top_module (
	input clk,
	input reset,
	input w,
	output z
);
	// Define the states
	parameter A = 0;
	parameter B = 1;
	parameter C = 2;
	parameter D = 3;
	parameter E = 4;
	parameter F = 5;
	
	// Define the state register
	reg [2:0] state;
	
	// Define the next state logic
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= A;
		end else begin
			case (state)
				A: begin
					if (w) begin
						state <= A;
					end else begin
						state <= B;
					end
				end
				
				B: begin
					if (w) begin
						state <= D;
					end else begin
						state <= C;
					end
				end
				
				C: begin
					if (w) begin
						state <= D;
					end else begin
						state <= E;
					end
				end
				
				D: begin
					if (w) begin
						state <= A;
					end else begin
						state <= F;
					end
				end
				
				E: begin
					if (w) begin
						state <= D;
					end else begin
						state <= E;
					end
				end
				
				F: begin
					if (w) begin
						state <= D;
					end else begin
						state <= C;
					end
				end
			endcase
		end
	end
	
	// Define the output logic
	always @(state) begin
		case (state)
			A: z = 0;
			B: z = 0;
			C: z = 0;
			D: z = 0;
			E: z = 1;
			F: z = 1;
		endcase
	end
endmodule
