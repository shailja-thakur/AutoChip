module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

reg d;

always @(posedge clk) begin
    if (state == 0) begin
        if (a & ^b)
            state <= 1;
        else
            state <= 0;
    end else begin
        if (a | b)
            state <= 1;
        else
            state <= 0;
    end
end

always @(posedge clk) begin
    if (state == 0)
        q <= 0;
    else
        q <= d;
end

always @(a, b) begin
    if (state == 0)
        d <= a & b;
    else
        d <= a | b;
end

endmodule
