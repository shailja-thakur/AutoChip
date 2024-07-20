module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

always @(posedge clk) begin
    if (reset)
        q <= 5'b00001; // reset value
    else begin
        q[4] <= q[0];                            // Shift and provide feedback
        q[3] <= q[4];
        q[2] <= q[3];
        q[1] <= q[2] ^ q[0];                    // Tap at bit position 3 (q[2]) and XOR with output bit q[0]
        q[0] <= q[1];
    end
end

endmodule
