module top_module(
    input clk,
    input reset,
    output reg [31:0] q);

    reg [31:0] q_next;
    reg [31:0] q_temp;
    
    always @(posedge clk) begin
        if (reset)
            q <= 32'h1;
        else
            q <= q_next;
    end
    
    always @(posedge clk) begin
        q_temp[31:0] <= {q[30:0], q[0]};
        q_next[31:0] <= {q_temp[30:0], q_temp[0] ^ (q_temp[21] ^ q_temp[1]), q_temp[0]};
    end
    
endmodule
