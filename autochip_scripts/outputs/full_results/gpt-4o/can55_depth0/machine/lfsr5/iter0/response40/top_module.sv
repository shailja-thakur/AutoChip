module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // First always block: State transition logic
    always @* begin
        q_next = q[4:1]; // Value of q except the LSB bit
        q_next[4] = q[0]; // The LSB bit is assigned to the MSB
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] is XORed with the LSB bit
    end

    // Second always block: Sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1; // Reset value
        else
            q <= q_next; // State transition at positive edge of clk
    end

endmodule
