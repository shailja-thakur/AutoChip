module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

    always @(posedge clk) begin
        if (L) begin
            Q <= R; // Load the value R into the register
        end
        else if (E) begin
            Q <= w; // Enable shifting the value w into the register
        end
        // If L and E are both 0, Q retains its value
    end

endmodule
