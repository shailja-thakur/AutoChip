module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    always @(*) begin
        q_next[4:1] = q[3:0]; // Assign q_next[4:1] with q[3:0]
        q_next[0] = q[4]; // Assign q_next[0] with q[4]
        q_next[2] = q[0] ^ q[2]; // Assign q_next[2] with q[0] XOR q[2]
    end

    always @(posedge clk) begin
        if (reset) begin
            q <= 5'b00001; // Assign q with reset value 5'b00001
        end
        else begin
            q <= q_next; // Assign q with q_next
        end
    end

endmodule
