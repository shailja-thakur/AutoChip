module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // reset to initial value 1 (00001 in binary)
        end
        else begin
            q[0] <= q[4]; // Shift operation
            q[1] <= q[0];
            q[2] <= q[1];
            q[3] <= q[2] ^ q[4]; // Tap at bit position 3
            q[4] <= q[3] ^ q[4]; // Tap at bit position 5 (output bit)
        end
    end

endmodule
