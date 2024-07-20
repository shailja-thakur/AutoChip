module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    // Internal register to store the next value of q
    reg [31:0] q_next;

    // Always block for sequential logic (registers)
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 32'h1; // Reset value
        end else begin
            q <= q_next; // Update q with q_next on clock rising edge
        end
    end

    // Always block for combinational logic (next state logic)
    always @* begin
        // Shift register logic
        q_next = {q[30:0], q[31] ^ q[21] ^ q[1] ^ q[0]};
    end

endmodule
