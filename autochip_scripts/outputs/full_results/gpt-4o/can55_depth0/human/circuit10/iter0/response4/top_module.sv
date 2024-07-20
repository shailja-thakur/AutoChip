module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (a == 1'b0 && b == 1'b0) begin
        q <= q;
        state <= state;
    end else if (a == 1'b0 && b == 1'b1) begin
        q <= 1'b1;
        state <= 1'b0;
    end else if (a == 1'b1 && b == 1'b0) begin
        q <= q;
        state <= state;
    end else if (a == 1'b1 && b == 1'b1) begin
        q <= ~q;
        state <= ~state;
    end
end

endmodule
