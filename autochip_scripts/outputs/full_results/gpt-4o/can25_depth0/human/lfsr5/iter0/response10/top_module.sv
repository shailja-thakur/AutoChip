module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // reset to 1
        end else begin
            q[0] <= q[4];                          // Shift logic for LSB
            q[1] <= q[0];                          // Shift logic for 2nd bit
            q[2] <= q[1];                          // Shift logic for 3rd bit
            q[3] <= q[2] ^ q[4];                   // XOR tap at bit position 3
            q[4] <= q[3];                          // Shift logic for 5th bit
        end
    end
endmodule
