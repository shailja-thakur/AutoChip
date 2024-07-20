module top_module (
	input clk,
	input in,
	input areset,
	output out
);
 
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
 
	reg [1:0] state, next_state;
 
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
		end else begin
			state <= next_state;
		end
	end
 
	always @(state, in) begin
		case (state)
			A: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = A;
				end
 
				out = 1'b0;
			end
 
			B: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
 
				out = 1'b0;
			end
 
			C: begin
				if (in) begin
					next_state = D;
				end else begin
					next_state = A;
				end
 
				out = 1'b0;
			end
 
			D: begin
				if (in) begin
					next_state = B;
				end else begin
					next_state = C;
				end
 
				out = 1'b1;
			end
		endcase
	end
endmodule
