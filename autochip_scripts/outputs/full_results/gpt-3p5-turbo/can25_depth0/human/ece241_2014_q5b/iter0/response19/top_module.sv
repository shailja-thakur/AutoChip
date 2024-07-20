module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [1:0] state, next_state;
	reg  z_output; //z_output is flip flop output
	wire z = z_output;

	parameter A = 2'b00;
	parameter B = 2'b01;

	always @(posedge clk, posedge areset)
	begin
		if (areset)
			state <= A;
		else
			state <= next_state;
	end

	always @*
	begin
		case(state)
			A: begin
				if (x)
					next_state = B;
				else
					next_state = A;
				z_output = x; 
			end
			
			B: begin
				if (x)
					next_state = B;
				else
					next_state = B;
				z_output = !x;
			end
		endcase
	end
endmodule
