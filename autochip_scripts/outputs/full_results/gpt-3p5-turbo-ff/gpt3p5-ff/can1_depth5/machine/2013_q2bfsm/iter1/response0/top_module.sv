module top_module (
	input clk,
	input resetn,
	input x,
	input y,
	output reg f,
	output reg g
);
	
	reg [3:0] state;
	
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= 4'b0000;  // initial state: A
		end else begin
			case (state)
				4'b0000: if (x) state <= 4'b0010; // A -> B
						 else state <= 4'b0000; // stay in A
				4'b0010: state <= 4'b0001; // B -> S0
				4'b0001: if (x) state <= 4'b0001; // S0 -> S1
						 else state <= 4'b1010; // S0 -> S10
				4'b1010: if (x) state <= 4'b1000; // S10 -> G1
						 else state <= 4'b0001; // S10 -> S0
				4'b1000: if (y) state <= 4'b0110; // G1 -> P1
						 else state <= 4'b0100; // G1 -> G2
				4'b0100: if (y) state <= 4'b0110; // G2 -> P1
						 else state <= 4'b0100; // G2 -> P0
				4'b0110: state <= 4'b0110; // P1 -> P1
				4'b1100: state <= 4'b1100; // P0 -> P0
			endcase
		end
	end
	
	always @(state) begin
		f <= (state == 4'b0010);
		g <= (state == 4'b1000) || (state == 4'b0100) || (state == 4'b0110);
	end
	
endmodule
