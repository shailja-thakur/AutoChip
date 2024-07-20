module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next; // next value of the register

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1; // reset q to initial value
        end else begin
            q <= q_next; // update q from q_next
        end

        // Update q_next on every clock cycle
        q_next[31] <= q[30] ^ q[20] ^ q[0];
        q_next[30:1] <= q[29:0];
    end

endmodule
