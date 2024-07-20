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
        Q <= R; // Load value from R input
    end
    else if (E) begin
        Q <= w; // Shift in value from w input
    end
end

endmodule
