module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	reg [1:0] state;
	
	always @(posedge clk, posedge areset)
	begin
		if (areset)
			state <= 2'b10; // State B
		else
		begin
			case (state)
				2'b00: if (in) state <= 2'b01; // State A
					   else state <= 2'b10; // State B
				2'b01: if (in) state <= 2'b00; // State B
					   else state <= 2'b01; // State A
				default: state <= 2'b10; // State B
			endcase
		end
	end
	
	assign out = (state == 2'b00);
	
endmodule
