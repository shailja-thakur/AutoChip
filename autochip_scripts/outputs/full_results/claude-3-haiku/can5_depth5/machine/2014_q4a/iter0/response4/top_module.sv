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
        // Hold current state
    end
    else if (L) begin
        // Update Q with R
        Q <= R;
    end
    else begin
        // Update Q with w
        Q <= w;
    end
end

endmodule
