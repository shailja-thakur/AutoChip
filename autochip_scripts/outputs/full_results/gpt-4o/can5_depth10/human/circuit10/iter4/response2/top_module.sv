module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        // State capture logic
        state <= a & (~b);
    end

    always @(*) begin
        // Output logic
        q = (state & b) | (~state & a);
    end

endmodule
