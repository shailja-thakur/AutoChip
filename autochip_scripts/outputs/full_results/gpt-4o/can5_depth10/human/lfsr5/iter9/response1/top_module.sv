module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001;  // Reset to 1
        end else begin
            // Galois LFSR feedback for taps at positions 5 (0 indexed 4) and 3 (0 indexed 2)
            q <= {q[3:0], (q[4] ^ q[2])};
        end
    end
endmodule
