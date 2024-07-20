module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q);

    reg [15:0] q_next;
    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            q_next <= 16'b0;
        else if (byteena[1])
            q_next[15:8] <= d[15:8];
        else
            q_next[15:8] <= q[15:8];
        
        if (!resetn)
            q_next <= 16'b0;
        else if (byteena[0])
            q_next[7:0] <= d[7:0];
        else
            q_next[7:0] <= q[7:0];
    end

    always @(posedge clk or negedge resetn) begin
        if (!resetn)
            q <= 16'b0;
        else
            q <= q_next;
    end
endmodule
