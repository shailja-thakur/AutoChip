module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset)
        q <= 4'b0001; // Set q to 1 when reset is active
    else if (q == 4'b1010) // If q is 10 (1010 in binary), reset to 1
        q <= 4'b0001;
    else
        q <= q + 1; // Otherwise increment q by 1
end

endmodule
