module top_module (
    input clk,
    input reset,
    output reg [31:0] q
);

    reg [31:0] q_next;

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1; // Reset the register to the initial value
        end else begin
            q <= q_next; // Update the register with the next value
        end
    end

    always @(*) begin
        q_next = {q[30:0], q[0] ^ q[21] ^ q[1]}; // Shift the register one bit to the left, with the least significant bit being the XOR of the current least significant bit, bit 21, and bit 1
    end

endmodule
