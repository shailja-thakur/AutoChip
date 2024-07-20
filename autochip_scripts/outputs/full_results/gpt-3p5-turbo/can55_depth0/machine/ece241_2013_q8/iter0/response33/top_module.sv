module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z,
	
	reg [1:0] state,
	reg [1:0] next_state
);

// State Definitions
parameter S = 2'b00;
parameter S1 = 2'b01;
parameter S10 = 2'b10;

always @(posedge clk or negedge aresetn) begin
	if (!aresetn) begin
		state <= S;
		z <= 0;
	end else begin
		state <= next_state;
		case (state)
			S: begin
				if (x == 1)
					next_state = S1;
				else
					next_state = S;
				
				z <= 0;
			end
			
			S1: begin
				if (x == 1)
					next_state = S1;
				else
					next_state = S10;
				
				z <= 0;
			end
			
			S10: begin
				if (x == 1)
					next_state = S1;
				else
					next_state = S;
				
				z <= x;
			end
			
		endcase
	end
end

endmodule
