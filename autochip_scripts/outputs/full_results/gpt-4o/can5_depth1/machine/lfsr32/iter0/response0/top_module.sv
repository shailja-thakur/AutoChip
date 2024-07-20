module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;

    always @(posedge clk or posedge reset) begin
        if (reset) 
            q <= 32'h1; // reset to initial value
        else
            q <= q_next;
    end

    always @(*) begin
        q_next[30:0] = q[31:1]; // Shift q by 1 bit to the right
        q_next[31] = q[0];      // Wrap around the bit shifted out of bit 0 to bit 31
        q_next[21] = q_next[21] ^ q[0];  // XOR bit 21 with bit 0 of q
        q_next[1] = q_next[1] ^ q[0];    // XOR bit 1 with bit 0 of q
        // Note: XORing bit 0 with itself always results in 0, so it is redundant to assign q_next[0] = q[0] ^ q[0]
    end
    
endmodule
