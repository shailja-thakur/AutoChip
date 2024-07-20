module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    always @(*) begin
        q_next = {q[3:0], q[0]}; // q_next = q[4:1], q[4] = q[0]
        q_next[2] = q_next[2] ^ q[0]; // XOR q_next[2] with q[0]
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // Reset value
        end else begin
            q <= q_next; // State transition
        end
    end
endmodule
