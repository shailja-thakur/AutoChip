module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // Always block for state transition
    always @(*) begin
        q_next = {q[3:0], q[0]};  // q_next = q[4:1], q_next[4] = q[0]
        q_next[2] = q[2] ^ q[0];  // q_next[2] is xored with q[0]
    end

    // Always block for sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1;  // Reset value
        end else begin
            q <= q_next;  // State transition
        end
    end

endmodule
