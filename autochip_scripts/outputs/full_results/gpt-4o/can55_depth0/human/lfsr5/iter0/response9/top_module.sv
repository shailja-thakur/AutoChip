module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Initialize state to 1 on reset
        end else begin
            q[4] <= q[3]; // Shift left
            q[3] <= q[2];
            q[2] <= q[1];
            q[1] <= q[0];
            q[0] <= q[4] ^ q[2]; // XOR feedback for bits 5 and 3
        end
    end
endmodule
