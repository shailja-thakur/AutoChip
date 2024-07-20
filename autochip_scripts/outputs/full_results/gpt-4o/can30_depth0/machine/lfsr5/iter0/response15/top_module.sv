module top_module(
    input clk,
    input reset,
    output reg [4:0] q);
    
    reg [4:0] q_next;

    always @* begin
        q_next = q[4:1];     // Shift right q by one bit
        q_next[4] = q[0];    // The MSB of q_next is the LSB of q
        q_next[2] = q_next[2] ^ q[0]; // XOR the 3rd bit with the LSB of q
    end

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1;  // Assign reset value to q
        else
            q <= q_next;  // Assign q_next to q at the rising edge of clk
    end

endmodule
