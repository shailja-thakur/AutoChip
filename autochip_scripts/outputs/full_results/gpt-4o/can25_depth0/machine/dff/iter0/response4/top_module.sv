module top_module(
    input clk,
    input d,
    output reg q
);

initial begin
    q = 1'hx;  // Initialize q to an unknown state
end

always @(posedge clk) begin
    q <= d;  // Sample d on the rising edge of clk
end

endmodule
