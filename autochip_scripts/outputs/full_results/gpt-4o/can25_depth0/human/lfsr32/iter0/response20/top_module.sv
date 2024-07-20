module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;  // Reset the output to 32'h1
        end
        else begin
            // Implement the Galois LFSR with taps at bit positions 32, 22, 2, and 1
            q[0]  <= q[31];
            q[1]  <= q[0] ^ q[31];
            q[2]  <= q[1] ^ q[31];
            q[31:3] <= q[30:2]; // Shift remaining bits
        end
    end
endmodule
