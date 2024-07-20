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
        Q <= R; // Load the value from R
    end
    else if (E) begin
        Q <= w; // Shift the input w into the first stage
    end
    // No else condition is needed, as the output Q will hold its previous value
end

endmodule
