module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk) begin
    if (reset)
        q <= 4'b0000;
    else
        q <= (q == 4'd9) ? 4'b0000 : q + 4'b0001;
end

endmodule
