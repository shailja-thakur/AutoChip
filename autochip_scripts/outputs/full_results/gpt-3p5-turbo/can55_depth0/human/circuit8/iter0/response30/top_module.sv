module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);
	
	// Define state variable
	reg state;
	
	// Define state machine transitions and outputs
	always @(posedge clock) begin
		case (state)
			0: begin
				if (a == 1'b1) begin
					p <= 1'b0;
					q <= 1'b0;
					state <= 1;
				end else begin
					p <= 1'b0;
					q <= 1'b0;
					state <= 0;
				end
			end
			
			1: begin
				p <= 1'b0;
				q <= 1'b0;
				if (a == 1'b0) begin
					state <= 2;
				end else begin
					state <= 1;
				end
			end
			
			2: begin
				p <= 1'b1;
				q <= 1'b0;
				if (a == 1'b1) begin
					state <= 3;
				end else begin
					state <= 2;
				end
			end
			
			3: begin
				p <= 1'b0;
				q <= 1'b1;
				if (a == 1'b0) begin
					state <= 0;
				end else begin
					state <= 3;
				end
			end
		endcase
	end
	
endmodule
