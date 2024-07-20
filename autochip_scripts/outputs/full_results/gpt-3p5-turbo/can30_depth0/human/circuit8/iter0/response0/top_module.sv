module top_module (
	input clock,
	input a, 
	output reg p,
	output reg q
);

reg p_next;
reg q_next;

always @(posedge clock) begin
    if (a) begin
        p_next <= 0;
        q_next <= 0;
    end else begin
        p_next <= 1;
        if (p || q) begin
            q_next <= 0;
        end else begin
            q_next <= 1;
        end
    end
end

always @(posedge clock) begin
    if (a) begin
        p <= p_next;
        q <= q_next;
    end
end

endmodule
