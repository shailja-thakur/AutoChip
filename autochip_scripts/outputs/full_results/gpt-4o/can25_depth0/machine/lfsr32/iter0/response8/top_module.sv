module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);
    reg [31:0] q_next;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1; // Reset register to initial value
        end else begin
            q <= q_next; // Update register with next value
        end
    end

    always @(*) begin
        q_next = {q[30:0], q[0] ^ q[21] ^ q[1]}; // Shift register and apply XOR feedback
    end
endmodule
