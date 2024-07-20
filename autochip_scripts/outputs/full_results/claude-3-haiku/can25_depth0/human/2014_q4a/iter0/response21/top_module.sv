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
        // Load
        Q <= R;
    end
    else if (E) begin
        // Shift
        Q <= w;
    end
    // Otherwise, hold previous value
end

endmodule
