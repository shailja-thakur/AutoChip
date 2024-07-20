module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // State transition logic
    always @(*) begin
        q_next = {q[3:0], q[0]};  // q_next is q with the LSB moved to MSB
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] is XORed with q[0]
    end

    // Sequential logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1;  // Reset value is 5'h1
        end else begin
            q <= q_next;  // State transition
        end
    end

endmodule
