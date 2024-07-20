module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    state <= q;

    // State transition logic
    if (a && b)
        q <= ~q;
    else if (a)
        q <= 0;
    else if (b)
        q <= 1;
    else
        q <= q; // Maintain the current state if both a and b are 0
end

endmodule
