module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    always @(*) begin
        q_next[4:1] = q[4:1]; // Assign q_next[4:1] with q[4:1]
        q_next[0] = q[0]; // Assign q_next[0] with q[0]
        q_next[2] = q[0] ^ q_next[2]; // Assign q_next[2] with the XOR of q[0] and q_next[2]
    end

    always @(posedge clk) begin
        if (reset)
            q <= 5'b00001; // Assign 5'h1 to q on reset
        else
            q <= q_next; // Assign q_next to q on positive clock edge
    end

endmodule
