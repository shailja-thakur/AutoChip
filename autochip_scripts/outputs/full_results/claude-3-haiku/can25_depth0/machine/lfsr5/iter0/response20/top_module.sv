module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    always @(*) begin
        q_next[4:1] = q[4:1]; // Assign q[4:1] to q_next[4:1]
        q_next[0] = q[0]; // Assign q[0] to q_next[0]
        q_next[2] = q[0] ^ q_next[2]; // XOR q[0] with q_next[2]
    end

    always @(posedge clk) begin
        if (reset) begin
            q <= 5'h1; // Assign reset value 5'h1 to q
        end else begin
            q <= q_next; // Assign q_next to q
        end
    end

endmodule
