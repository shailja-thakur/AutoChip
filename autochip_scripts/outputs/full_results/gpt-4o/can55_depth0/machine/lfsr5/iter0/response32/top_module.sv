module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // State transition always block
    always @(*) begin
        q_next = {q[0], q[4:1]};  // Shift q to right and place q[0] in the MSB
        q_next[2] = q_next[2] ^ q[0]; // XOR q[0] with q_next[2]
    end

    // Sequential always block
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // Reset value
        end else begin
            q <= q_next; // State transition
        end
    end

endmodule
