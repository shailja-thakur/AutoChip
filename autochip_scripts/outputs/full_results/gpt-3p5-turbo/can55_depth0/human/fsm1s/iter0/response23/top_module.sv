module top_module (
	input clk,
	input in,
	input reset,
	output out
);
	
	reg [1:0] state;
	always @(posedge clk or posedge reset) begin
		if (reset)
			state <= 2'b10;
		else begin
			case(state)
				2'b00: begin // state B
					if (in)
						state <= 2'b10;
					else
						state <= 2'b00;
				end
				2'b10: begin // state A
					if (in)
						state <= 2'b10;
					else
						state <= 2'b00;
				end
			endcase
		end
	end
	
	assign out = (state == 2'b00) ? 1'b0 : 1'b1;
	
endmodule
