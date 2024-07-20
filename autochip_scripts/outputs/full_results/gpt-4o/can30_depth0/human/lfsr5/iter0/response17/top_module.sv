module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'b00001; // Set LFSR output to 1 on reset
        end else begin
            q[4] <= q[0];          // Shift bit: q[4] gets q[0]
            q[3] <= q[4] ^ q[0];   // Tap at bit position 4: q[3] gets q[4] XOR q[0]
            q[2] <= q[3];          // Shift bit: q[2] gets q[3]
            q[1] <= q[2];          // Shift bit: q[1] gets q[2]
            q[0] <= q[1];          // Shift bit: q[0] gets q[1]
        end
    end
endmodule
