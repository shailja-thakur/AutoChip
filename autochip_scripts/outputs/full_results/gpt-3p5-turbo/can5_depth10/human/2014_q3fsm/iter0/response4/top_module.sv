module top_module (
	input clk,
	input reset,
	input s,
	input w,
	output reg z
);

reg [1:0] state, next_state;

parameter A = 2'b00;
parameter B = 2'b01;

always @(posedge clk or posedge reset) begin
	if (reset) begin
		state <= A;
	elseif (state == A) begin
		if (s == 1)
			state <= B;
		else
			state <= A;
	end 
	elseif (state == B) begin
		if (w == 1) begin
			if ({w, w} == 2'b10)
				state <= A;
			else
				state <= B;
		end 
	end 
end

always @(posedge clk) begin
	if (state == B) begin
		if ({w, w} == 2'b10)
			z <= 1;
		else
			z <= 0;
	end 
	else
		z <= 0;
end

endmodule
