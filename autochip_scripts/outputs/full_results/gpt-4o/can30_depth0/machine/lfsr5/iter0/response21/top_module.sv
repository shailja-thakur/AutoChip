module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // Always block for state transition
    always @(q) begin
        q_next = q[4:1]; // q_next[3:0] assigned with q[4:1]
        q_next[4] = q[0]; // q_next[4] assigned with q[0] (LSB)
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] XORed with q[0]
    end

    // Always block for state updating
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // Reset value
        end else begin
            q <= q_next; // State transition value
        end
    end
endmodule
