module top_module (
	input clk,
	input areset,
	input x,
	output reg z
);

	typedef enum logic [1:0] {
		S_IDLE,
		S_ONE,
		S_FLIP
	} state_t;
	
	state_t state, next_state;
	reg first_one_found;

	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= S_IDLE;
			first_one_found <= 0;
		end else begin
			state <= next_state;
			if (state == S_ONE || state == S_FLIP) begin
				first_one_found <= 1;
			end
		end
	end

	always @(*) begin
		case (state)
			S_IDLE: begin
				if (x == 1'b1) 
					next_state = S_FLIP;
				else 
					next_state = S_IDLE;
			end
			S_ONE: begin
				next_state = S_FLIP;
			end
			S_FLIP: begin
				next_state = S_FLIP;
			end
			default: next_state = S_IDLE;
		endcase
	end
	
	always @(posedge clk or posedge areset) begin
		if (areset) 
			z <= 0;
		else if (first_one_found) begin
			if (state == S_IDLE)
				z <= ~x;
			else
				z <= x;
		end else
			z <= x;
		
	end

endmodule
