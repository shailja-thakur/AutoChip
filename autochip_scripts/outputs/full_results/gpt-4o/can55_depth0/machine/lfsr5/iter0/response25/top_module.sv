module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    // State transition always block triggered when q changes
    always @(q) begin
        q_next = q[4:1];      // Assign q_next with q except the LSB
        q_next[4] = q[0];     // Assign q_next[4] with the LSB of q
        q_next[2] = q_next[2] ^ q[0]; // XOR q_next[2] with the LSB of q
    end

    // Logic description always block triggered at positive edge of clk
    always @(posedge clk) begin
        if (reset) begin
            q <= 5'h1; // If reset is active, assign q with 5'h1
        end else begin
            q <= q_next; // If reset is inactive, assign q with q_next
        end
    end

endmodule
