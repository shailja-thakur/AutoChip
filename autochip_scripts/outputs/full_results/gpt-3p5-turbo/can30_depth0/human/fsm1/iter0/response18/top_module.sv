module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	reg [1:0] state;
	
	parameter B = 2'b00;
	parameter A = 2'b01;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= B;
		end else begin
			case (state)
				B: begin
					if (in == 0) begin
						state <= A;
					end else begin
						state <= B;
					end
				end
				A: begin
					if (in == 0) begin
						state <= B;
					end else begin
						state <= A;
					end
				end
			endcase
		end
	end
	
	assign out = (state == A) ? 1'b1 : 1'b0;
	
endmodule
