module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 4'b0001; // Reset to 1
    else if (q == 4'b1010) 
        q <= 4'b0001; // Reset to 1 when reaching 10
    else
        q <= q + 1; // Increment by 1
end

endmodule
