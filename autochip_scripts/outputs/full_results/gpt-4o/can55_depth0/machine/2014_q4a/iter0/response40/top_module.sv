module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk or posedge R) begin
    // Reset dominates over the rest of the logic
    if (R) begin
        Q <= 1'b0;
    end else if (E) begin
        // When E is high, allow updates to Q
        if (L) begin
            Q <= R;
        end else begin
            Q <= w;
        end
    end
    // When E is low, Q retains its value
end

endmodule
