module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

	parameter S = 2'b00;
	parameter S1 = 2'b01;
	parameter S10 = 2'b10;
	
	reg [1:0] state, state_next;
	
	always @(posedge clk or negedge aresetn) begin
		if (~aresetn) begin
			state <= S;
		end
		else begin
			state <= state_next;
		end
	end
	
	always @* begin
		case (state)
			S: begin
				if (x == 1'b0) begin
					state_next = S;
				end
				else begin
					state_next = S1;
				end
				z = 1'b0;
			end
			
			S1: begin
				if (x == 1'b0) begin
					state_next = S10;
				end
				else begin
					state_next = S1;
				end
				z = 1'b0;
			end
			
			S10: begin
				if (x == 1'b0) begin
					state_next = S;
				end
				else begin
					state_next = S1;
				end
				z = x;
			end
		endcase
	end
	
endmodule
