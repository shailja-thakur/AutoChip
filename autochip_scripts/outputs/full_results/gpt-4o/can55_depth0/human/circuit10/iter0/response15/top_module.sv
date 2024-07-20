module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (a & b) begin
        q <= ~q;
        state <= ~state;
    end else if (a) begin
        q <= q;
        state <= 0;
    end else if (b) begin
        q <= 1;
        state <= state;
    end else begin
        q <= 0;
        state <= 0;
    end
end

endmodule
