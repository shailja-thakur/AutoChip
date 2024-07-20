module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Reset state to 1
        end else begin
            // Feedback polynomial: x^5 + x^3 + 1
            q[0] <= q[4]; // Shift register operation with feedback
            q[1] <= q[0];
            q[2] <= q[1];
            q[3] <= q[2] ^ q[4]; // Tap at bit position 3
            q[4] <= q[3];
        end
    end
endmodule
