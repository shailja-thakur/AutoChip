module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    // Define the next state variable
    reg [4:0] q_next;

    // Always block to define the state transition logic
    always @(*) begin
        // Assign q_next with q[4:1] which is q except the LSB bit
        q_next = q[4:1];
        // Assign q_next[4] with q[0], which is the LSB bit
        q_next[4] = q[0];
        // q_next[2] is XORed with q[0]
        q_next[2] = q_next[2] ^ q[0];
    end

    // Always block triggered at positive edge of clk
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // If reset is active, assign q with 5'h1
            q <= 5'h1;
        end else begin
            // If reset is inactive, assign q with q_next
            q <= q_next;
        end
    end

endmodule
