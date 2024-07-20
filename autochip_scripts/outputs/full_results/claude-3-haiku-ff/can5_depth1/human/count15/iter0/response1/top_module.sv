module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset)
        q <= 4'b0;
    else
        q <= (q == 4'd15) ? 4'b0 : q + 1;
end

endmodule
