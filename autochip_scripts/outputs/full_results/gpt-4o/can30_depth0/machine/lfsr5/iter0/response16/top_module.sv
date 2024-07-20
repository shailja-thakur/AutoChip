module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);
    
    reg [4:0] q_next;

    // Define state transitions and logic description
    always @(q) begin
        q_next[3:0] = q[4:1]; // q_next gets the value of q except the LSB
        q_next[4] = q[0];     // q_next[4] is assigned with q[0]
        q_next[2] = q_next[2] ^ q[0]; // q_next[2] is xored with q[0]
    end

    // Define state transition on positive edge of clk
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 5'h1;        // Reset value
        end else begin
            q <= q_next;      // State transition
        end
    end

endmodule
