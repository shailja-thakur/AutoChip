module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output reg out
);

	reg [1:0] state;
	parameter OFF = 2'b00;
	parameter ON = 2'b01;
	
	always @(posedge clk or posedge reset) begin
		if (reset) begin
			state <= OFF;
			out <= 1'b0;
		end
		else begin
			case(state)
				ON: begin
					if (k)
						state <= OFF;
				end
				
				OFF: begin
					if (j)
						state <= ON;
				end
					
				default: state <= OFF;
			endcase
			case(state)
				ON: out <= 1'b1;
				OFF: out <= 1'b0;
				default: out <= 1'b0;
			endcase
		end
	end
    
endmodule
