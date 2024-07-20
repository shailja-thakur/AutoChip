module top_module(
    input clk,
    input reset,
    output reg [4:0] q);
    
    reg [4:0] q_next;

    // First always block to define the state transition of q
    always @(*) begin
        q_next = {q[0], q[4:1]}; // q_next is assigned with q[4:1] and q[0] (reordering bits)
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] is XORed with q[0]
    end

    // Second always block to handle the positive edge of clk
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // q is assigned with reset value 5'h1
        end
        else begin
            q <= q_next; // q is assigned with q_next
        end
    end

endmodule
