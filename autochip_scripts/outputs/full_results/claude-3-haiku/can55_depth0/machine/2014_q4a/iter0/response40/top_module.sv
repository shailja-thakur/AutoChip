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
        // Hold the current state
        Q <= Q;
    end
    else if (L) begin
        // Update the output with the value of R
        Q <= R;
    end
    else begin
        // Update the output with the value of w
        Q <= w;
    end
end

endmodule
