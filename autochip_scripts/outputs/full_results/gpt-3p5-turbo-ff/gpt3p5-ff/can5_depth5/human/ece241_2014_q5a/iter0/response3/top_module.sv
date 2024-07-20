module top_module (
	input clk,
	input areset,
	input x,
	output z
);

reg [3:0] state;
reg [3:0] next_state;
reg z;

parameter S0 = 4'b0000;
parameter S1 = 4'b0001;

always @(posedge clk or posedge areset) begin
	if (areset) begin
		state <= S0;
		z <= 0;
	end
	else begin
		state <= next_state;
		z <= (state == S1) ? ~x + 1'b1 : z;
	end
end

always @* begin
	case (state)
		S0: next_state = (x == 1'b0) ? S0 : S1;
		S1: next_state = (x == 1'b1) ? S1 : S0;
	endcase
end

endmodule
