module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg prev_a;
reg prev_p;
reg prev_q;

always @(posedge clock) begin
	prev_a <= a;
	prev_p <= p;
	prev_q <= q;

	if (clock) begin
		if ((prev_a == 0) && (prev_p == 0) && (prev_q == 0)) begin
			p <= 0;
			q <= 0;
		end else if ((prev_a == 1) && (prev_p == 0) && (prev_q == 0)) begin
			p <= 0;
			q <= 0;
		end else if ((prev_a == 1) && (prev_p == 0) && (prev_q == 1)) begin
			p <= 0;
			q <= 0;
		end else if ((prev_a == 1) && (prev_p == 1) && (prev_q == 0)) begin
			p <= 0;
			q <= 0;
		end else if ((prev_a == 1) && (prev_p == 1) && (prev_q == 1)) begin
			p <= 1;
			q <= 1;
		end else if ((prev_a == 0) && (prev_p == 1) && (prev_q == 1)) begin
			p <= 1;
			q <= 1;
		end else if ((prev_a == 0) && (prev_p == 1) && (prev_q == 0)) begin
			p <= 1;
			q <= 1;
		end else if ((prev_a == 0) && (prev_p == 0) && (prev_q == 1)) begin
			p <= 0;
			q <= 1;
		end
	end
end

endmodule
