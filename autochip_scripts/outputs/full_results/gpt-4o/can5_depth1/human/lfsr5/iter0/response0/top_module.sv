module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 5'b00001; // Synchronous reset to the state '00001'
    end
    else begin
        q[0] <= q[4];
        q[1] <= q[0];
        q[2] <= q[1];
        q[3] <= q[2];
        q[4] <= q[3] ^ q[4] ^ q[2]; // Taps at bit positions 5 and 3
    end
end

endmodule
