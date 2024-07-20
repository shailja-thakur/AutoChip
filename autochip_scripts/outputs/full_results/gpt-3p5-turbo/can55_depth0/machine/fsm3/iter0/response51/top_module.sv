module top_module (
	input clk,
	input in,
	input areset,
	output reg out
);

	reg [1:0] state;
	
	always @(posedge clk or posedge areset) begin
		if (areset) begin
			state <= 2'b00; // state A
			out <= 0;
		end else begin
			case (state)
				2'b00: state <= (in) ? 2'b01 : 2'b00; // state A
				2'b01: state <= (in) ? 2'b01 : 2'b10; // state B
				2'b10: state <= (in) ? 2'b11 : 2'b00; // state C
				2'b11: state <= (in) ? 2'b01 : 2'b10; // state D
				default: state <= 2'b00; // state A
			endcase
			
			out <= (state == 2'b11) ? 1'b1 : 1'b0;
		end
	end
	
endmodule
