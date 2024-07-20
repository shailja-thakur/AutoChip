module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset)
			state <= 2'b00;  // reset to state A
		else begin
			case (state)
				2'b00:  // state A
					state <= (in) ? 2'b01 : 2'b00;
				2'b01:  // state B
					state <= (in) ? 2'b01 : 2'b10;
				2'b10:  // state C
					state <= (in) ? 2'b11 : 2'b00;
				2'b11:  // state D
					state <= (in) ? 2'b01 : 2'b10;
			endcase
		end
	end
	
	assign out = (state == 2'b11) ? 1'b1 : 1'b0;
	
endmodule
