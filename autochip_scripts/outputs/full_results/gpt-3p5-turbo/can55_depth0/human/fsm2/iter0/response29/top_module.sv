module top_module (
	input clk,
	input j,
	input k,
	input areset,
	output out
);
	
	reg [1:0] state;
	assign out = (state == 1) ? 1'b1 : 1'b0;
	
	always @ (posedge clk or posedge areset) begin
		if (areset)
			state <= 2'h0;
		else begin
			case (state)
				2'h0: begin
					if (j)
						state <= 2'h1;
					else
						state <= 2'h0;
				end
				2'h1: begin
					if (k)
						state <= 2'h0;
					else
						state <= 2'h1;
				end
			endcase
		end
	end
	
endmodule
