module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001;  // Active-high synchronous reset sets output to 1
        end else begin
            q[0] <= q[4];  // Shift register operation
            q[1] <= q[0];
            q[2] <= q[1];
            q[3] <= q[2] ^ q[4];  // Tap at bit position 3 (xor with q[4])
            q[4] <= q[3];
        end
    end
endmodule
