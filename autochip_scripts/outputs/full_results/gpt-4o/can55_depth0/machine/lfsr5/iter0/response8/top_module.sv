module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // State transition logic block
    always @(*) begin
        q_next = {q[3:0], q[0]}; // q_next[4:1] = q[3:0], q_next[4] = q[0]
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] XOR q[0]
    end

    // State update block
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // Reset value of q
        end else begin
            q <= q_next; // Update q with q_next
        end
    end

endmodule
