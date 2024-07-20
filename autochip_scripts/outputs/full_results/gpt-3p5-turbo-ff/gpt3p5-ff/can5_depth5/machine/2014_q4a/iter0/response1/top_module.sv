module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (E == 1'b0) begin
        Q <= Q; // Hold the current state of Q
    end else begin
        if (L == 1'b1) begin
            Q <= R; // Update Q with the value of R
        end else begin
            Q <= w; // Update Q with the value of w
        end
    end
end

endmodule
