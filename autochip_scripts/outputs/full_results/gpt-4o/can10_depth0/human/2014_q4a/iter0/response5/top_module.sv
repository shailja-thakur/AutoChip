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
        Q <= R; // Load R value
    end else if (E) begin
        Q <= w; // Shift w into Q
    end
    // If neither L nor E is asserted, Q retains its value
end

endmodule
