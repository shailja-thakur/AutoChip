module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	reg [1:0] state;
	parameter A = 2'b00;
	parameter B = 2'b01;
	parameter RESET = 2'b11;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= B;
		end else begin
			case(state)
				A: begin
					if (in) begin
						state <= A;
					end else begin
						state <= B;
					end
				end
				
				B: begin
					if (in) begin
						state <= B;
					end else begin
						state <= A;
					end
				end
			endcase
		end
	end
	
	always @(state) begin
		case(state)
			A: out = 0;
			B: out = 1;
		endcase
	end	
	
endmodule
