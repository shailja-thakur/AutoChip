module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;
    
    // State transition logic
    always @(q) begin
        q_next = {q[3:0], q[0]}; // q_next is q[4:1] and q[4] is q[0]
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] is xored with q[0]
    end
    
    // State update on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // Reset state
        end else begin
            q <= q_next; // State transition
        end
    end

endmodule
