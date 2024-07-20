module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	// Define states
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter C = 2'b10;
	parameter D = 2'b11;
	
	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= A;
		end else begin
			case (state)
				A: begin
					if (in) begin
						state <= B;
					end else begin
						state <= A;
					end
				end
				
				B: begin
					if (in) begin
						state <= B;
					end else begin
						state <= C;
					end
				end
				
				C: begin
					if (in) begin
						state <= D;
					end else begin
						state <= A;
					end
				end
				
				D: begin
					if (in) begin
						state <= B;
					end else begin
						state <= C;
					end
				end
			endcase
		end
	end
	
	assign out = (state == D) ? 1'b1 : 1'b0;
	
endmodule
