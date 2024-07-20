module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    // First always block - state transition logic
    always @(*) begin
        q_next = q[4:1];  // State transition without LSB bit
        q_next[4] = q[0];  // Assign LSB to MSB
        q_next[2] = q_next[2] ^ q[0];  // XOR q_next[2] with LSB
    end

    // Second always block - output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1;  // Reset value
        end else begin
            q <= q_next;  // State transition on clock edge
        end
    end

endmodule
