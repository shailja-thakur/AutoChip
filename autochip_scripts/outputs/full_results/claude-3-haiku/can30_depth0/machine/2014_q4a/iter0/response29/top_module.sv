module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (~E) begin
        // Hold the current state of Q
        // E = 0, so don't update Q
    end
    else if (L) begin
        // L = 1, so update Q with the value of R
        Q <= R;
    end
    else begin
        // L = 0, so update Q with the value of w
        Q <= w;
    end

    if (R) begin
        // R = 1, so reset Q to 0
        Q <= 1'b0;
    end
end

endmodule
