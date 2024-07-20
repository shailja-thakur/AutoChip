module top_module(
    input clk,
    input reset,
    output reg [31:0] q);
    
    reg [31:0] q_next;

    always @(posedge clk or posedge reset) begin
        if (reset)
            q <= 32'h1;
        else
            q <= q_next;
    end

    always @(*) begin
        // combine bits 21, 1, and 0 and shift them into the bit 31 position
        q_next = {q[30:0], (q[21] ^ q[1] ^ q[0])};
    end
endmodule
