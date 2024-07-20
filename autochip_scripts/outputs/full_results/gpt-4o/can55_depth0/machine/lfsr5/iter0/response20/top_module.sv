module top_module(
    input clk,
    input reset,
    output reg [4:0] q);

    reg [4:0] q_next;

    // First always block: Define state transitions
    always @* begin
        q_next = q[4:1];   // Assign q_next with q[4:1]
        q_next[4] = q[0];  // Assign q_next[4] with q[0]
        q_next[2] = q_next[2] ^ q[0];  // XOR q_next[2] with q[0]
    end

    // Second always block: Triggered at the positive edge of clk
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1;     // If reset is active, assign q with reset value 5'h1
        end else begin
            q <= q_next;   // If reset is inactive, assign q with q_next
        end
    end
endmodule
