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
        Q <= 1'b0; // Reset the output to 0
    end
    else if (E) begin
        if (L) begin
            Q <= R; // Update the output with the value of R
        end
        else begin
            Q <= w; // Update the output with the value of w
        end
    end
    // If E is low, hold the output in its current state
end

endmodule
