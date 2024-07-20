module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;

    // Combinational logic for the next state of the shift register
    always @* begin
        q_next[31] = q[0];                      // Bit 0 shifted back to bit 31
        q_next[30:1] = q[31:2];                 // Shift the register right by 1 bit
        q_next[0] = q[0] ^ q[21] ^ q[1];        // Bit 0 XORed with bits 21 and 1
    end

    // Sequential logic to update the shift register
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 32'h1;                         // Reset the register to 32'h1
        else
            q <= q_next;                        // Update the register with the next state
    end

endmodule
