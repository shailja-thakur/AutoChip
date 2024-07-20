module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    // Define the state transition always block
    always @(*) begin
        q_next = {q[3:0], q[0]}; // q_next is q[4:1] with q[0] appended at MSB
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] xored with q[0]
    end

    // Define the sequential always block
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // reset value
        end else begin
            q <= q_next; // state transition
        end
    end

endmodule
