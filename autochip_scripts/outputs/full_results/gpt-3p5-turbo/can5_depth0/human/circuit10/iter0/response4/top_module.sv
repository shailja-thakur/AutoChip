module top_module (
    input clk,
    input a,
    input b,
    output q,
    output state
);

reg q;
reg state;

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
    end else begin
        q <= 1;
    end

    if (clk == 1'b1)
        state <= a & b;
end

assign state = q;

endmodule
