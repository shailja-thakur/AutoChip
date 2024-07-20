module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg q_next;

always @(posedge clk) begin
    if (E) begin
        if (L)
            q_next <= R;
        else
            q_next <= w;
    end
    else begin
        q_next <= Q;
    end
end

always @(negedge clk) begin
    if (E)
        Q <= q_next;
end

endmodule
