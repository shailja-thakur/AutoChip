module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

reg D;
reg Q_temp;

always @(posedge clk) begin
    if (E) begin
        if (L) begin
            D <= R;
        end else begin
            D <= Q_temp;
        end
    end else begin
        D <= w;
    end
end

always @(posedge clk) begin
    if (E) begin
        if (L) begin
            Q_temp <= R;
        end else begin
            Q_temp <= D;
        end
    end else begin
        Q_temp <= w;
    end
end

always @(posedge clk) begin
    Q <= Q_temp;
end

endmodule
