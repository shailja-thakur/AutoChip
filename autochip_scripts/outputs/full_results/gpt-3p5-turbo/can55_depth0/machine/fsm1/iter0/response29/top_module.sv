module top_module (
	input clk,
	input in,
	input areset,
	output out
);

	reg [1:0] state, next_state;

	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b10;
		else
			state <= next_state;
	end

	always @(state, in) begin
		case (state)
			2'b00: if (in)
						next_state = 2'b00;
				    else 
				    	next_state = 2'b01;
			2'b01: if (in)
						next_state = 2'b01;
				    else 
				    	next_state = 2'b00;
		endcase
	end

	assign out = (state == 2'b01);

endmodule
