module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (a == 1 && b == 1) begin
        q <= ~q;
    end else if (a == 0 && b == 1) begin
        q <= 1;
    end else if (a == 1 && b == 0) begin
        q <= 0;
    end
    state <= q;
end

endmodule
