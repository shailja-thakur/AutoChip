module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 5'd1; // Reset the LFSR output to 1
    end
    else begin
        q[4:1] <= q[3:0]; // Shift register
        q[0] <= q[4] ^ q[2]; // Compute the next value using the taps at bit positions 5 and 3
    end
end

endmodule
