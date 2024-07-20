module top_module(
    input clk,
    input reset,
    output reg [4:0] q);
    
    // The correct taps for a 5-bit maximal-length Galois LFSR
    // with the taps at bit positions 5 (q[4]) and 3 (q[2])
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001;  // Reset to 1
        end else begin
            q <= {q[3:0], q[4] ^ q[2]};  // Taps at bit positions 5 and 3 (index 4 and 2)
        end
    end
endmodule
