module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output f,
	output g
);

	reg [1:0] state, next_state;
	always @(posedge clk or negedge resetn) begin
		if (~resetn)
			state <= 2'b00; // A state
		else
			state <= next_state;
	end
	
	// State register assignments
	localparam A = 2'b00;
	localparam B = 2'b01;
	localparam C = 2'b10;
	
	always @* begin
		case (state)
			A: begin
				f = 1'b0;
				g = 1'b0;
				if (resetn & ~resetn)
					next_state = B;
				else
					next_state = A;
			end
			
			B: begin
				f = 1'b1;
				g = 1'b0;
				next_state = C;
			end
			
			C: begin
				if ((x == 1'b1) && (x == 1'b0) && (x == 1'b1))
					g = 1'b1;
				else if (y == 1'b1)
					g = 1'b1;
				else if (y !== 1'b1)
					g = 1'b0;
				next_state = C;
			end
		endcase
	end
	
endmodule
