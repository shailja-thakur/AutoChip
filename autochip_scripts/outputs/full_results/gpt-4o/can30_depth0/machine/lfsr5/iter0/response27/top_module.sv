module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // Logic description and state transition
    always @* begin
        q_next = {q[3:0], q[0]}; // q_next[4:1] = q[4:1] and q_next[0] = q[0]
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] XORed with q[0]
    end

    // State transition at positive edge of clk
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1; // Reset value
        end else begin
            q <= q_next; // State transition
        end
    end

endmodule
