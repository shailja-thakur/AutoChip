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
        if (E == 1'b0) begin
            Q_next <= Q;  // Hold Q in its current state
        end
        else begin
            if (L == 1'b1) begin
                Q_next <= R;  // Update Q with the value of R
            end
            else begin
                Q_next <= w;  // Update Q with the value of w
            end
        end
    end

    always @(posedge clk) begin
        Q <= Q_next;
    end

endmodule
