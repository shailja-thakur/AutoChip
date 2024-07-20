module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	reg [1:0] state, next_state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00; // State A
		else
			state <= next_state;
	end
	
	always @(state, x) begin
		case (state)
			2'b00: begin // State A
				if (x)
					next_state = 2'b01; // State B
				else
					next_state = 2'b00; // State A
				z = 1'b0;
			end
			2'b01: begin // State B
				if (x)
					next_state = 2'b10; // State B
				else
					next_state = 2'b01; // State B
				z = 1'b1;
			end
			default: begin
				next_state = 2'b00; // State A
				z = 1'b0;
			end
		endcase
	end
	
endmodule
