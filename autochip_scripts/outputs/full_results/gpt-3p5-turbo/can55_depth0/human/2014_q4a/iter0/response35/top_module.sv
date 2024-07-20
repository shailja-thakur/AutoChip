module top_module (
	input clk,
	input w,
	input R,
	input E,
	input L,
	output reg Q
);

// Internal wires and registers
reg q_next;
reg r_next;

// Dataflow logic
always @(posedge clk) begin
	if (E) begin
		if (L) begin
			q_next <= R;
			r_next <= R;
		end else begin
			q_next <= w;
			r_next <= q_next;
		end
	end else begin
		q_next <= q_next;
		r_next <= r_next;
	end
end

// Output assignment
always @(posedge clk) begin
	Q <= q_next;
end

endmodule
