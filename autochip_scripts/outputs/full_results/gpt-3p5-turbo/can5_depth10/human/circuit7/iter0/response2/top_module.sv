module top_module (
    input clk,
    input a,
    output reg q
);

	reg q_next;
	
	always @(posedge clk)
	begin
		if (a == 1'b0)
			q_next = 1'b1;
		else
			q_next = ~q;
	end
	
	always @(posedge clk)
	begin
		q <= q_next;
	end

endmodule
