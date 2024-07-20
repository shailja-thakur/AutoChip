module top_module (
    input clk,
    input w,
    input R,
    input E,
    input L,
    output reg Q
);

always @(posedge clk) begin
    if (~E) begin
        Q <= Q; // Hold current state
    end
    else if (L) begin
        Q <= R; // Update Q with R
    end
    else begin
        Q <= w; // Update Q with w
    end
end

endmodule
