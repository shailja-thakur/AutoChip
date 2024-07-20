module top_module (
	input clk,
	input in,
	input reset,
	output reg out
);

parameter A = 0;
parameter B = 1;

reg [1:0] state;

always @(posedge clk)
begin
	if (reset)
		state <= B;
	else
	begin
		if (state == A)
			state <= in ? A : B;
		else
			state <= in ? B : A;
	end
end

assign out = (state == B) ? 1 : 0;

endmodule
