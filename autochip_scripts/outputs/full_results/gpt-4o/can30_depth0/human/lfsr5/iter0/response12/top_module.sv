module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Reset state to 1
        end else begin
            q[4] <= q[0];
            q[3] <= q[4];
            q[2] <= q[3] ^ q[0]; // Tap at bit position 3
            q[1] <= q[2];
            q[0] <= q[1] ^ q[0]; // Tap at bit position 5
        end
    end

endmodule
