module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 5'b1; // Reset the LFSR to 1
    end else begin
        q[4] <= q[0] ^ q[2]; // Compute the next state
        q[3:0] <= q[4:1]; // Shift the register
    end
end

endmodule
