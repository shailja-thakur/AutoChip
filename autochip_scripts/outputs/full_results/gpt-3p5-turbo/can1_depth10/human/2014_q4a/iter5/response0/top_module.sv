module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg Q_next;

always @(posedge clk) begin
    if (E) begin
        if (L)
            Q_next <= R;
        else if (Q == 1'b1)
            Q_next <= w;
        else
            Q_next <= Q;
    end
    else
        Q_next <= Q;
end

always @(posedge clk) begin
    if (E && L) begin
        Q <= R;
    end
    else if (E && !L) begin
        Q <= Q_next;
    end
    else if (!E && L) begin
        Q <= w;
    end
end

endmodule
