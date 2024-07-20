module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	reg [1:0] state;
	reg [1:0] next;
	
	always @(posedge clk) begin
		if (~resetn) //reset signal is low
			state <= 2'b01; //state A
		else
			state <= next;
	end
	
	always @(state, r) begin
		case (state)
			2'b01: begin
				if (r[1]) //if r[1] is high
					next <= 2'b10; //state B
				else if (r[2]) //if r[2] is high
					next <= 2'b11; //state C
				else if (r[3]) //if r[3] is high
					next <= 2'b00; //state D
				else
					next <= 2'b01; //state A
			end
			2'b10: begin
				if (r[1])
					next <= 2'b10; //state B
				else
					next <= 2'b01; //state A
			end
			2'b11: begin
				if (r[2])
					next <= 2'b11; //state C
				else
					next <= 2'b01; //state A
			end
			2'b00: begin
				if (r[3])
					next <= 2'b00; //state D
				else
					next <= 2'b01; //state A
			end
			default: next <= 2'b01; //state A
		endcase
	end
	
	assign g[1] = (state == 2'b10) ? 1'b1 : 1'b0;
	assign g[2] = (state == 2'b11) ? 1'b1 : 1'b0;
	assign g[3] = (state == 2'b00) ? 1'b1 : 1'b0;
	
endmodule
