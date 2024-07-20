module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);
	reg [1:0] state;
	always @(posedge clk or posedge reset)
	begin
		if (reset)
			state <= 2'b00;
		else
		begin
			case (state)
				2'b00: if (in) state <= 2'b01; else state <= 2'b00;
				2'b01: if (in) state <= 2'b10; else state <= 2'b01;
				2'b10: if (in) state <= 2'b11; else state <= 2'b00;
				2'b11: if (in) state <= 2'b10; else state <= 2'b01;
			endcase
		end
	end
	
	always @(state)
	begin
		case (state)
			2'b00: out <= 1'b0;
			2'b01: out <= 1'b0;
			2'b10: out <= 1'b0;
			2'b11: out <= 1'b1;
		endcase
	end
	
endmodule
