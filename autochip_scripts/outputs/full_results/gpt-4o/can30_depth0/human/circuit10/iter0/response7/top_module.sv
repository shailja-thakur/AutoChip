module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    always @(posedge clk) begin
        if (a && b) begin
            q <= ~q;    // q toggles when both a and b are 1
        end else if (!a && b) begin
            q <= 1;     // q is set to 1 when a is 0 and b is 1
        end else if (a && !b) begin
            q <= 0;     // q is set to 0 when a is 1 and b is 0
        end
        state <= q;     // state follows q
    end

endmodule
