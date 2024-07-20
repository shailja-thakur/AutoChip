module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

    reg [31:0] q_next;

    // Sequential logic for updating q register
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 32'h1; // Initial value
        else
            q <= q_next;
    end

    // Combinational logic for calculating q_next
    always @(*) begin
        q_next = {q[30:0], q[0] ^ q[1] ^ q[21]};
    end

endmodule
