module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Reset state to 1
        end
        else begin
            // Compute feedback based on taps at bit positions 5 and 3
            // Since q[4] is the 5th bit and q[2] is the 3rd bit
            q <= {q[3:0], (q[4] ^ q[2])};
        end
    end
endmodule
