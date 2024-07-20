module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 5'b1; // Reset the LFSR output to 1
    end
    else begin
        q[4] <= q[3] ^ q[0]; // Compute the next value using the taps at bit positions 5 and 3
        q[3:0] <= q[4:1]; // Shift the LFSR
    end
end

endmodule
