module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

reg [4:0] next_q;

always @(posedge clk) begin
    if (reset) begin
        q <= 5'b00001; // Reset the LFSR to 1, not 0
    end
    else begin
        q <= next_q;
    end
end

always @(*) begin
    next_q = {q[3:0], q[4] ^ q[2]}; // Shift and XOR the taps at positions 5 and 3
end

endmodule
