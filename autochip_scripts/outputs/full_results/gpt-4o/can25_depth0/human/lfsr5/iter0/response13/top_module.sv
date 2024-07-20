module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Reset to state 1
        end
        else begin
            q[0] <= q[4];  // Shift
            q[1] <= q[0];
            q[2] <= q[1];
            q[3] <= q[2];
            q[4] <= q[3] ^ q[4]; // XOR with bit 4 to implement the tap
        end
    end
endmodule
