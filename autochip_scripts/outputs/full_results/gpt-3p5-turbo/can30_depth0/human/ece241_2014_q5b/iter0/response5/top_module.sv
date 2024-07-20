module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	reg [1:0] state, next_state;
	always @(posedge clk, posedge areset)
	begin
		if (areset)
			state <= 2'b00;
		else
			state <= next_state;
	end
	
	wire z_temp;
	assign z = z_temp;
	
	always @(state, x)
	begin
		case (state)
			2'b00: begin
				if (x)
					next_state = 2'b01;
				else
					next_state = 2'b00;
				z_temp = 1'b0;
			end
			
			2'b01: begin
				if (x)
					next_state = 2'b00;
				else
					next_state = 2'b01;
				z_temp = 1'b1;
			end
		endcase
	end
endmodule
