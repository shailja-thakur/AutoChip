module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (a == 1'b1) begin
        state <= b;
        q <= b;
    end else if (a == 1'b0) begin
        q <= state;
    end
end

endmodule
