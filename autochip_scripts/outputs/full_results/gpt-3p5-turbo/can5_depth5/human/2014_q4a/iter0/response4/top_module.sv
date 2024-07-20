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
        if (E == 1) begin
            if (L == 1) begin
                Q <= R;
            end else begin
                Q <= Q_next;
            end
        end else begin
            Q <= Q;
        end
    end

    always @(w or Q) begin
        if (w == 1) begin
            Q_next <= R;
        end else begin
            Q_next <= Q;
        end
    end

endmodule
