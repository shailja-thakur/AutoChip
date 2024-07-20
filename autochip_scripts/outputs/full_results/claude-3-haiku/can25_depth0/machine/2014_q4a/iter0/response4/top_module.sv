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
        // Hold output Q in current state
        Q <= Q;
    end
    else if (L) begin
        // Update output Q with value of R
        Q <= R;
    end
    else begin
        // Update output Q with value of w
        Q <= w;
    end
end

endmodule
