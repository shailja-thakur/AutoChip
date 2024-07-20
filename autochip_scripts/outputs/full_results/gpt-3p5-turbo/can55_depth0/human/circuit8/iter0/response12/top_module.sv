module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

	reg [1:0] state;
	
	always @(posedge clock) begin
		if (state == 0) begin
			if (a == 1'b0)
				state <= 1;
		end else if (state == 1) begin
			if (a == 1'b1)
				state <= 2;
		end else if (state == 2) begin
			if (a == 1'b0)
				state <= 3;
		end else if (state == 3) begin
			if (a == 1'b1)
				state <= 0;
		end
	end
	
	always @(state) begin
		case (state)
			0: begin
				p <= 1'b0;
				q <= 1'b0;
			end
			1: begin
				p <= 1'b0;
				q <= 1'b0;
			end
			2: begin
				p <= 1'b0;
				q <= 1'b0;
			end
			3: begin
				p <= 1'b0;
				q <= 1'b1;
			end
		endcase
	end
endmodule
