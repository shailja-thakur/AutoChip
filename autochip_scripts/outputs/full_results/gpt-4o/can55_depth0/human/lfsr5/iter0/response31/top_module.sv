module top_module(
    input clk,
    input reset,
    output reg [4:0] q);
    
    always @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001; // Reset state
        end
        else begin
            q[0] <= q[4]; // Shift bit 4 to bit 0
            q[1] <= q[0]; // Shift bit 0 to bit 1
            q[2] <= q[1]; // Shift bit 1 to bit 2
            q[3] <= q[2]; // Shift bit 2 to bit 3
            q[4] <= q[3] ^ q[4]; // XOR bit 3 and bit 4, shift result to bit 4
        end
    end
endmodule
