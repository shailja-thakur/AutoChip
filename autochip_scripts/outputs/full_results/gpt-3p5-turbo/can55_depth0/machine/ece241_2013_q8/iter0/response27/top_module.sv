module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	parameter S = 0;
	parameter S1 = 1;
	parameter S10 = 2;
	
	reg [1:0] state;
	reg [1:0] state_next;
	
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end else begin
			state <= state_next;
		end
	end
	
	always @(state or x) begin
		case (state)
			S: begin
				if (x == 1) begin
					state_next = S1;
				end else begin
					state_next = S;
				end
				z = 0;
			end
			
			S1: begin
				if (x == 1) begin
					state_next = S1;
				end else begin
					state_next = S10;
				end
				z = 0;
			end
			
			S10: begin
				if (x == 1) begin
					state_next = S1;
				end else begin
					state_next = S;
				end
				z = x;
			end
			
			default: begin
				state_next = S;
				z = 0;
			end
		endcase
	end
	
endmodule
