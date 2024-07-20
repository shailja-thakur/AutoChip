module top_module (
	input clk,
	input aresetn,
	input x,
	output reg z
);

reg [2:0] state;
always @(posedge clk or negedge aresetn)
begin
	if (!aresetn)
		state <= 3'b000;
	else
		case (state)
			3'b000: if (x == 1'b1)
						state <= 3'b001;
					else
						state <= 3'b000;
			3'b001: if (x == 1'b0)
						state <= 3'b010;
					else
						state <= 3'b000;
			3'b010: if (x == 1'b1)
						begin
							state <= 3'b000;
							z <= 1'b1;
						end
					else
						state <= 3'b011;
			3'b011: if (x == 1'b0)
						state <= 3'b010;
					else
						state <= 3'b000;
		endcase
end

endmodule
