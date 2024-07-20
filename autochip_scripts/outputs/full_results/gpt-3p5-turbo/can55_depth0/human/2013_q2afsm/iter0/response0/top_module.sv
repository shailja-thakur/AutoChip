module top_module (
	input clk,
	input resetn,
	input [3:1] r,
	output [3:1] g
);

	// Define state codes
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state;
	
	// Sequential logic for state flip-flops
	always @(posedge clk or negedge resetn) begin
		if (~resetn) begin
			state <= A;
		end 
		else begin
			case (state)
				A: begin
					if (r[1] && ~r[2] && ~r[3])
						state <= B;
					else if (~r[1] && r[2] && ~r[3])
						state <= C;
					else if (~r[1] && ~r[2] && ~r[3])
						state <= D;
				end
				
				B: begin
					if (r[1] && g[1])
						state <= B;
					else if (~r[1])
						state <= A;
				end
				
				C: begin
					if (r[2] && g[2])
						state <= C;
					else if (~r[2])
						state <= A;
				end
				
				D: begin
					if (r[1] && ~r[2] && ~r[3])
						state <= A;
				end
			endcase
		end
	end
	
	// Combinational logic for outputs g[i]
	assign g[1] = (state == B) ? 1'b1 : 1'b0;
	assign g[2] = (state == C) ? 1'b1 : 1'b0;
	assign g[3] = (state == D) ? 1'b1 : 1'b0;
	
endmodule
