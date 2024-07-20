module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001;  // Reset to 1
        end else begin
            q[4] <= q[0];                      // Shift and apply feedback
            q[3] <= q[4];
            q[2] <= q[3];
            q[1] <= q[2];
            q[0] <= q[1] ^ q[4];  // XOR with the tap at bit position 5 (q[4])
        end
    end
endmodule
