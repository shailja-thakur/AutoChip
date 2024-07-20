module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);
	parameter OFF = 0;
	parameter ON = 1;
	
	reg [1:0] state;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= OFF;
		end else begin
			case (state)
				ON: begin
					if (k) begin
						state <= OFF;
					end
				end
				OFF: begin
					if (j) begin
						state <= ON;
					end
				end
			endcase
		end
	end
	
	assign out = (state == ON) ? 1'b1 : 1'b0;
	
endmodule
