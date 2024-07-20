module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (a && b) begin
        q <= ~q;
        state <= q;
    end
    else if (a && !b) begin
        q <= 1'b0;
        state <= q;
    end
    else if (!a && b) begin
        q <= 1'b1;
        state <= q;
    end
    else begin
        state <= q;
    end
end

endmodule
