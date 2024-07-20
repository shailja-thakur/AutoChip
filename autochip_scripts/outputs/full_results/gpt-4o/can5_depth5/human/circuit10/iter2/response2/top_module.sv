module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

always @(posedge clk) begin
    if (b) begin
        state <= a;
    end
    q <= state;
end

endmodule
