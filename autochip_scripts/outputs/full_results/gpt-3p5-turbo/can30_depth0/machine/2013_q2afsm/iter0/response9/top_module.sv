module top_module (
	input clk,
	input resetn,
	input [2:0] r,
	output reg [2:0] g
);

	reg [1:0] state;
	reg [1:0] next_state;
	
	always @(posedge clk) begin
		if (!resetn)
			state <= 2'b00;  // state A
		else
			state <= next_state;
	end
	
	always @(*) begin
		case (state)
			2'b00: begin  // state A
				if (r[0])
					next_state = 2'b01;  // state B
				else if (r[1])
					next_state = 2'b10;  // state C
				else if (r[2])
					next_state = 2'b11;  // state D
				else
					next_state = 2'b00;  // state A
			end
			
			2'b01: begin  // state B
				if (r[0])
					next_state = 2'b01;  // state B
				else
					next_state = 2'b00;  // state A
			end
			
			2'b10: begin  // state C
				if (r[1])
					next_state = 2'b10;  // state C
				else
					next_state = 2'b00;  // state A
			end
			
			2'b11: begin  // state D
				if (r[2])
					next_state = 2'b11;  // state D
				else
					next_state = 2'b00;  // state A
			end
		endcase
	end
	
	always @(state) begin
		case (state)
			2'b01: g[0] = 1'b1;
			2'b10: g[1] = 1'b1;
			2'b11: g[2] = 1'b1;
			default: begin
				g[0] = 1'b0;
				g[1] = 1'b0;
				g[2] = 1'b0;
			end
		endcase
	end
endmodule
