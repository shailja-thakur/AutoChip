module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

always @(posedge clk) begin
    if (reset) begin
        q <= 5'b00001; // Reset the LFSR to 1
    end
    else begin
        q <= {q[3] ^ q[0], q[4:1]}; // Shift and XOR the bits at positions 5 and 3
    end
end

endmodule
