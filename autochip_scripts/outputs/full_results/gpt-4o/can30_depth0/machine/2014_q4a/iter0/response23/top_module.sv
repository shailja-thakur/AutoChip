module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (R) begin
        Q <= 1'b0; // Reset Q to 0 when R is high
    end else if (E) begin
        if (L) begin
            Q <= R; // If L is high, update Q with value of R
        } else begin
            Q <= w; // If L is low, update Q with value of w
        end
    end
    // If E is low, retain the current state of Q
end

endmodule
