module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    // State transition block
    always @(*) begin
        q_next = q[4:1]; // Assign q_next with the value of q except the LSB bit
        q_next[4] = q[0]; // Assign q_next[4] with the LSB bit of q
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] is assigned with q_next[2] xored with q[0]
    end

    // Logic description block
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // Assign q with 5'h1 on reset
        end else begin
            q <= q_next; // Assign q with q_next on positive edge of clk
        end
    end

endmodule
