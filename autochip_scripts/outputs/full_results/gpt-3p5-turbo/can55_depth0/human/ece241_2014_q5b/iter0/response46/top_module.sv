module top_module (
	input clk,
	input areset,
	input x,
	output z
);

	reg [1:0] state;
	always @(posedge clk or posedge areset)
	begin
		if (areset)
			state <= 2'b00; // state A
		else
		begin
			case (state)
				2'b00: state <= (x) ? 2'b10 : 2'b00; // state A transition conditions
				2'b10: state <= (x) ? 2'b10 : 2'b01; // state B transition conditions
				default: state <= 2'b10; // default state B
			endcase
		end
	end

	assign z = (state == 2'b01) ? 1'b1 : 1'b0; // z output condition
		
endmodule
