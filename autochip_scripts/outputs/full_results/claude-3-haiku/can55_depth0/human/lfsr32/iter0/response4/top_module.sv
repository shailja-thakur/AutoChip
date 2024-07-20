module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    // Galois LFSR with taps at bit positions 32, 22, 2, and 1
    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1;
        end
        else begin
            q <= {q[30:0], q[31] ^ q[21] ^ q[1] ^ q[0]};
        end
    end

endmodule
