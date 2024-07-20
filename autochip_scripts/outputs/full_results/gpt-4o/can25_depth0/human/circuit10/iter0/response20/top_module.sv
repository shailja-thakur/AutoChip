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
        state <= 1;
    end else if (a && !b) begin
        q <= 1;
        state <= 0;
    end else if (!a && b) begin
        q <= 1;
        state <= state;
    end else begin
        q <= state;
        state <= state;
    end
end

endmodule
