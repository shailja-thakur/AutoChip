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
        Q <= 0; // Reset the register to a known state
    end else if (E) begin
        if (L) begin
            Q <= R; // Load the value of R into the register
        } else begin
            Q <= w; // Load the value of w into the register
        end
    end
    // If E is low, hold Q in its current state (do nothing)
end

endmodule
