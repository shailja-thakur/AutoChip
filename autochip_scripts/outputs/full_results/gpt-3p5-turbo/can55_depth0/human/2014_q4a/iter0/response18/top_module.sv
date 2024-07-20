module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

reg q_next; // next value of Q
reg q_cur; // current value of Q

always @(posedge clk) begin
	// update the current value of Q to the next value
	q_cur <= q_next;
end

always @* begin
	if (E && L) begin
		// load the value R into the shift register
		q_next <= R;
	end else begin
		// shift the value in the shift register
		q_next <= {q_cur[(n-2):0], w};
	end
end

assign Q = q_cur; // output the current value of Q

endmodule
