module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	reg [1:0] state;
	reg [1:0] next_state;
	reg [1:0] output;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b0;
		else
			state <= next_state;
	end
	
	always @(state, x) begin
		case (state)
			2'b00: begin
				next_state = 2'b01;
				output = 2'b00;
			end
			
			2'b01: begin
				next_state = 2'b10;
				output = ~x;
			end
			
			2'b10: begin
				next_state = 2'b00;
				output = x + 1'b1;
			end
			
			default: begin
				next_state = 2'b00;
				output = 2'b00;
			end
		endcase
	end
	
	assign z = output;
	
endmodule
