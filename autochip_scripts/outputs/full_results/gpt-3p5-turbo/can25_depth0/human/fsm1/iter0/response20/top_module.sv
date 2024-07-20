module top_module (
	input clk,
	input in,
	input areset,
	output out
);
	
	reg [1:0] state;
	assign out = state[0];
	
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= 2'b10; // reset to state B
		else
		begin
			case (state)
				2'b00: state <= in ? 2'b01 : 2'b00; // A (0)
				2'b01: state <= in ? 2'b01 : 2'b00; // A (1)
				2'b10: state <= in ? 2'b10 : 2'b11; // B (0)
				2'b11: state <= in ? 2'b10 : 2'b11; // B (1)
				default: state <= 2'b00;
			endcase
		end
	end

endmodule
