module top_module(
    input clk,
    input reset,
    output reg [4:0] q
);

    reg [4:0] q_next;

    always @(*) begin
        // Assign q_next with q[4:1]
        q_next[3:0] = q[4:1];
        
        // q_next[4] is assigned with q[0]
        q_next[4] = q[0];
        
        // q_next[2] is XORed with q[0]
        q_next[2] = q_next[2] ^ q[0];
    end
    
    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 5'h1;
        else
            q <= q_next;
    end

endmodule
