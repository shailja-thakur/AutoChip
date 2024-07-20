module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

reg state;
reg q;

always @(posedge clk) begin
    if (state == 0 && a == 0 && b == 0)
        state <= 0;
    else if (state == 0 && a == 0 && b == 1)
        state <= 1;
    else if (state == 0 && a == 1 && b == 0)
        state <= 2;
    else if (state == 0 && a == 1 && b == 1)
        state <= 3;
    else if (state == 1 && a == 0 && b == 0)
        state <= 1;
    else if (state == 1 && a == 0 && b == 1)
        state <= 2;
    else if (state == 1 && a == 1 && b == 0)
        state <= 3;
    else if (state == 1 && a == 1 && b == 1)
        state <= 0;
    else if (state == 2 && a == 0 && b == 0)
        state <= 2;
    else if (state == 2 && a == 0 && b == 1)
        state <= 3;
    else if (state == 2 && a == 1 && b == 0)
        state <= 0;
    else if (state == 2 && a == 1 && b == 1)
        state <= 1;
    else if (state == 3 && a == 0 && b == 0)
        state <= 3;
    else if (state == 3 && a == 0 && b == 1)
        state <= 0;
    else if (state == 3 && a == 1 && b == 0)
        state <= 1;
    else if (state == 3 && a == 1 && b == 1)
        state <= 2;
end

always @(posedge clk) begin
    if (state == 0)
        q <= 0;
    else
        q <= 1;
end

assign state = q;

endmodule
