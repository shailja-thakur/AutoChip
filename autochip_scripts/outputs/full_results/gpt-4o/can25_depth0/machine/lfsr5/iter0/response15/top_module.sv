module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // State transition logic
    always @(*) begin
        q_next = {q[0], q[4:1]}; // q_next[4:1] = q[3:0], q_next[0] = q[4]
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] gets xored with q[0]
    end

    // Sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // Reset state
        end else begin
            q <= q_next; // State transition
        end
    end

endmodule
