module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // State transition logic
    always @(*) begin
        q_next = {q[0], q[4:1]}; // Rotate right
        q_next[2] = q_next[2] ^ q[0]; // Xor q_next[2] with LSB of q
    end

    // State update on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // Reset value
        end else begin
            q <= q_next; // State transition
        end
    end

endmodule
