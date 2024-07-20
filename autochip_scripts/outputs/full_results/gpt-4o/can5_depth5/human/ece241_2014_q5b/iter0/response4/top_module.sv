module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	// State Encoding using One-Hot
	reg [1:0] state;
	reg [1:0] next_state;
	
	// State Definitions
	localparam A = 2'b01;
	localparam B = 2'b10;
	
	// State Transition Logic
	always @(*) begin
		case (state)
			A: begin
				if (x) begin
					next_state = B;
					z = 1;
				} else begin
					next_state = A;
					z = 0;
				end
			end
			
			B: begin
				if (x) begin
					next_state = B;
					z = 0;
				} else begin
					next_state = B;
					z = 1;
				end
			end
			
			default: begin
				next_state = A;
				z = 0;
			end
		endcase
	end
	
	// State Flip-Flops with asynchronous reset
	always @(posedge clk or posedge areset) begin
		if (areset) 
			state <= A;
		else
			state <= next_state;
	end

endmodule
