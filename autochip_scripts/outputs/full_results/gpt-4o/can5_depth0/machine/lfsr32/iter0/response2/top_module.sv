module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 32'h1;  // Reset the register to the initial value
        else
            q <= q_next;  // Update the register with the next value
    end

    always @* begin
        q_next = {q[30:0], q[31] ^ q[21] ^ q[1] ^ q[0]};  // Shift left and feed the output back, XORing specific bits
    end

endmodule
