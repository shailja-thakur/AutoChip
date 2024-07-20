module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;

    always @(*) begin
        // Shift q left by 1, input new bits with specified XOR logic
        q_next[31] = q[0]; // Input bit sent to bit 31
        q_next[30:1] = q[29:0]; // Shift left
        // Calculate new bit 0 based on XOR operations
        q_next[0] = q[0] ^ q[21] ^ q[1];
    end

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1; // Reset value
        end else begin
            q <= q_next; // Update the register with q_next
        end
    end

endmodule
