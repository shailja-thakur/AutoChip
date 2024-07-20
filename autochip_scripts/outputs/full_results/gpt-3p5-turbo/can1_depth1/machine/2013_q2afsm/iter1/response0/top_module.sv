module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output [2:0] g
);
	
	reg [1:0] state;
	reg [1:0] next_state;
	reg [2:0] g_reg;
	
	always @(posedge clk) begin
		if (!resetn)
			state <= 2'b00;
		else
			state <= next_state;
	end
	
	always @(*) begin
		case (state)
			2'b00: begin
				if (r[2])
					next_state = 2'b01;
				else if (r[1])
					next_state = 2'b10;
				else if (r[0])
					next_state = 2'b11;
				else
					next_state = 2'b00;
			end
			
			2'b01: begin
				if (r[2])
					next_state = 2'b01;
				else
					next_state = 2'b00;
			end
			
			2'b10: begin
				if (r[1])
					next_state = 2'b10;
				else
					next_state = 2'b00;
			end
			
			2'b11: begin
				if (r[0])
					next_state = 2'b11;
				else
					next_state = 2'b00;
			end
		endcase
	end
	
	always @(state) begin
		case (state)
			2'b01: g_reg[2] = 1'b1;
			2'b10: g_reg[1] = 1'b1;
			2'b11: g_reg[0] = 1'b1;
			default: g_reg = 3'b000;
		endcase
	end
	
	assign g = g_reg;
	
endmodule
