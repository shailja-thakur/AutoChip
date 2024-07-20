module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    always @(*) begin
        // Define next state logic
        q_next = {q[0], q[4:1]};
        q_next[2] = q_next[2] ^ q[0];
    end

    always @(posedge clk or posedge reset) begin
        // Define state transitions
        if (reset) begin
            q <= 5'h1;
        end else begin
            q <= q_next;
        end
    end

endmodule
