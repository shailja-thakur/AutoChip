module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

always @(posedge clk or posedge reset) begin
    if (reset) begin
        q <= 5'b11111; // Reset to 11111 (1 in binary)
    end
    else begin
        q <= {q[3:0], q[4] ^ q[2]}; // Tap positions 5 and 3
    end
end

endmodule
