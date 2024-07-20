module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next; // next value of the register

    always @(posedge clk) begin
        if (reset) begin
            q <= 32'h1; // reset q to initial value
        end else begin
            q <= q_next[31:0]; // update q from q_next
        end
        
        // Update q_next on every clock cycle
        q_next[0] <= q[31] ^ q[21] ^ q[1];
        q_next[31:1] <= q[30:0];
    end

endmodule
