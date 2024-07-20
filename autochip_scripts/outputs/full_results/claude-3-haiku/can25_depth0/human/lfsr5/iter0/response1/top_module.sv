module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 5'b00001; // Reset output to 1
    end
    else begin
        q[4:1] <= q[3:0]; // Shift bits
        q[0] <= q[4] ^ q[2]; // Compute next bit using taps at positions 5 and 3
    end
end

endmodule
