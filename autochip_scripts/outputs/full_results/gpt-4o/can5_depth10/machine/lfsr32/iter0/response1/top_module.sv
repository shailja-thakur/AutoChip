module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;

    // Update the q register on the rising edge of the clock or reset
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            q <= 32'h1; // Reset the register to the initial value
        else
            q <= q_next; // Update the register with the next value
    end

    // Compute the next value of the register
    always @(*)
    begin
        // Shift the register and XOR required bits
        q_next = { q[30:0], q[31] ^ q[0] ^ q[21] ^ q[1] };
    end
endmodule
