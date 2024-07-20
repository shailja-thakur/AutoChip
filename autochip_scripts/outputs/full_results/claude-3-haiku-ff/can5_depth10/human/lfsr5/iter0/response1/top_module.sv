module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 5'b00001; // Reset to 1
    end
    else begin
        q[4] <= q[0] ^ q[2]; // Tap positions 5 and 3
        q[3:0] <= q[4:1]; // Shift register
    end
end

endmodule
