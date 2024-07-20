module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (state == 0) begin
        if (a == 0 && b == 0)
            q <= 0;
        else if (a == 0 && b == 1)
            q <= 1;
        else if (a == 1 && b == 0)
            q <= 1;
        else if (a == 1 && b == 1)
            q <= 0;
    end
    state <= q;
end

endmodule
