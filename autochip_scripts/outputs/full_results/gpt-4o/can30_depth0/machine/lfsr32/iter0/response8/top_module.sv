module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

    reg [31:0] q_next;

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 32'h1;
        else
            q <= q_next;
    end

    always @(*) begin
        // Shift q to the right by one and feedback bit 0 shifted out
        q_next = {q[0] ^ q[1] ^ q[21], q[31:1]};
    end

endmodule
