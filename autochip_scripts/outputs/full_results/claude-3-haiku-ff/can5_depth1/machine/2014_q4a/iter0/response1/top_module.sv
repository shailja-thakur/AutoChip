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
        Q <= Q; // Hold the current state of Q
    end
    else if (L) begin
        Q <= R; // Update Q with the value of R
    end
    else begin
        Q <= w; // Update Q with the value of w
    end
end

endmodule
