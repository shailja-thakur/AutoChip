module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

// 5-bit maximal-length Galois LFSR with taps at bit positions 5 and 3
// Reset the LFSR output to 1

always @(posedge clk) begin
    if (reset) begin
        q <= 5'b00001;
    end
    else begin
        q <= {q[3:0], q[4] ^ q[2]};
    end
end

endmodule
