module top_module(
    input clk,
    input reset,
    output reg [31:0] q
);

    // Internal register to store the next value of 'q'
    reg [31:0] q_next;

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1; // Reset to initial value
        end else begin
            q <= q_next; // Update 'q' with the next value
        end
    end

    always @(*) begin
        // Compute the next value of 'q'
        q_next = {q[30:0], q[31]};
        q_next[0] = q[0] ^ q[1] ^ q[21];
    end

endmodule
