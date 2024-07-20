module moore_state_machine (
	input clk,
	input in,
	input areset,
	output out
);

	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] current_state, next_state;
	reg out_reg;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			current_state <= A;
		else
			current_state <= next_state;
	end
	
	always @(current_state or in) begin
		case (current_state)
			A: begin
				if (in)
					next_state <= B;
				else
					next_state <= A;
				out_reg <= 0;
			end
			B: begin
				if (in)
					next_state <= B;
				else
					next_state <= C;
				out_reg <= 0;
			end
			C: begin
				if (in)
					next_state <= D;
				else
					next_state <= A;
				out_reg <= 0;
			end
			D: begin
				if (in)
					next_state <= B;
				else
					next_state <= C;
				out_reg <= 1;
			end
		endcase
	end
	
	assign out = out_reg;
	
endmodule
module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	moore_state_machine fsm (
		.clk(clk),
		.in(in),
		.areset(areset),
		.out(out)
	);
	
endmodule
