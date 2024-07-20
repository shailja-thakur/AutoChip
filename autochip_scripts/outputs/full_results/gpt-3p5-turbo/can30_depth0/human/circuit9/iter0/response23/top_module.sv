module top_module (
    input wire clk,
    input wire a,
    output reg [2:0] q
);

always @(posedge clk) begin
    if (a)
        q <= q + 1;
    else
        q <= 0;
end

endmodule
