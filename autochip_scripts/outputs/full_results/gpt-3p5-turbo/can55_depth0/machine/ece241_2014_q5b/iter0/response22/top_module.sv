module top_module (
	input clk,
	input areset,
	input x,
	output z
);
	
	parameter A = 2'b00;
	parameter B = 2'b01;
	
	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= A;
		else begin
			case (state)
				A: begin
					if (x)
						state <= B;
					else
						state <= A;
				end
				
				B: state <= B;
			endcase
		end
	end
	
	assign z = (state == A && x) || (state == B && ~x);
	
endmodule
