module top_module (
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    // Always block to define state transitions
    always @(*) begin
        q_next[3:0] = q[4:1]; // q_next is assigned with q[4:1], except the LSB bit
        q_next[4] = q[0];     // q_next[4] is assigned with the LSB bit of q
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] is XORed with the LSB bit of q
    end

    // Always block triggered on the positive edge of the clock signal
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // reset value
        end else begin
            q <= q_next; // state transition
        end
    end

endmodule
