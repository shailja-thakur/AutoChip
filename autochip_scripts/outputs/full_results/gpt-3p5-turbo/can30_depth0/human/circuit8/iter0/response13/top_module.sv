module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg p_temp;
reg q_temp;

always @(posedge clock) begin
    p_temp <= a;
    q_temp <= p_temp;
end

always @(posedge clock) begin
    p <= a;
end

always @(posedge clock) begin
    q <= q_temp;
end

endmodule
