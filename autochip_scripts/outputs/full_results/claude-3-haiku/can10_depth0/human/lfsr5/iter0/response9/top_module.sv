module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 5'b1; // Reset the LFSR output to 1
    end
    else begin
        q[4] <= q[3]; // Shift the bits
        q[3] <= q[2];
        q[2] <= q[1];
        q[1] <= q[0];
        q[0] <= q[4] ^ q[2]; // XOR the tapped bits to produce the next state
    end
end

endmodule
