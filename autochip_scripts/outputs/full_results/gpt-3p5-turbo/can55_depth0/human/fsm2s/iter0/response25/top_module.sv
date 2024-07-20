module top_module (
	input clk,
	input j,
	input k,
	input reset,
	output out
);
	
	reg [1:0] state;
	
	always @(posedge clk, posedge reset) begin
		if (reset)
			state <= 2'b0;
		else begin
			case (state)
				2'b00: begin
					if (j)
						state <= 2'b01;
					else
						state <= 2'b00;
				end
					
				2'b01: begin
					if (k)
						state <= 2'b00;
					else
						state <= 2'b01;
				end
			endcase
		end
	end
	
	always @(state) begin
		case (state)
			2'b00: out = 1'b0;
			2'b01: out = 1'b1;
		endcase
	end
	
endmodule
