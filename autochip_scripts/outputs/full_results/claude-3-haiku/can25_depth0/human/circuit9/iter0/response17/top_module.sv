module top_module (
    input clk,
    input a, 
    output reg [2:0] q
);

// This sequential circuit has the following behavior:
// - When a is 1, q increments by 1 on each rising edge of clk, up to a value of 4.
// - When a transitions from 1 to 0, q is reset to 0.
// - When a is 0, q increments by 1 on each rising edge of clk, up to a value of 6.

always @(posedge clk) begin
    if (a) begin
        if (q < 4)
            q <= q + 1;
    end
    else begin
        if (q < 6)
            q <= q + 1;
        else
            q <= 0;
    end
end

endmodule
