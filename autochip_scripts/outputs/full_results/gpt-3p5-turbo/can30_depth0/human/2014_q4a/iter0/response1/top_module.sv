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
        if (L) begin
            Q_next <= R;
        end else begin
            Q_next <= Q;
        end
    end else begin
        Q_next <= Q;
    end
end

always @(posedge clk) begin
    if (E) begin
        if (L) begin
            Q <= R;
        end else begin
            Q <= w;
        end
    end else begin
        Q <= Q_next;
    end
end

endmodule
