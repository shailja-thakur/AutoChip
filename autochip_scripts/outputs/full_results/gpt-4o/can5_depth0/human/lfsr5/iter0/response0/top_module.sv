module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Reset state
        end else begin
            // Galois LFSR with taps at bit positions 5 and 3
            q <= {q[3:0], q[4] ^ q[2]};
        end
    end

endmodule
