module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (!E) begin
        Q <= Q; // Hold the current value of Q when E is low
    end
    else begin
        if (L) begin
            Q <= R; // Update Q with the value of R when L is high
        end
        else begin
            Q <= w; // Update Q with the value of w when L is low
        end
    end
end

endmodule
