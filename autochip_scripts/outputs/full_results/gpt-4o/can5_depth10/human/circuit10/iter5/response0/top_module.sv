module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        // Capture logic for state and q
        q <= (state & b) | (~state & a);
        state <= a & (~b);
    end

endmodule
