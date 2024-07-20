module top_module(
    input clk,
    input [7:0] d,
    input reset,
    output reg [7:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) 
        q <= 8'b0;
    else 
        q <= d;
end

endmodule
