module top_module (
    input clock,
    input a,
    output reg p,
    output reg q
);

reg p_temp;
reg q_temp;

always @(posedge clock) begin
    if (a == 1'b0) begin
        p_temp <= 1'b0;
    end else begin
        p_temp <= 1'b1;
    end
end

always @(posedge clock) begin
    if (p_temp == 1'b1) begin
        q_temp <= 1'b0;
    end else begin
        q_temp <= 1'b1;
    end
end

always @(posedge clock) begin
    p <= p_temp;
    q <= q_temp;
end

endmodule
