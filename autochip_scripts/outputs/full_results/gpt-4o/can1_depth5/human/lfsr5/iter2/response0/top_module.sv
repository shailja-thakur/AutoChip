module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Reset to 1
        end else begin
            // Taps at bit positions 5 and 3, corresponding to q[4] and q[2]
            q <= {q[3], q[2], q[1], q[0], q[4] ^ q[2]};
        end
    end
endmodule
