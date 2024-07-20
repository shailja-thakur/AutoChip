module top_module(
    input clk,
    input resetn,
    input [1:0] byteena,
    input [15:0] d,
    output reg [15:0] q
);
    reg [15:0] q_next;
    
    always @(posedge clk or negedge resetn) begin
        if (!resetn) begin
            q <= 16'h0000;
        end else begin
            q <= q_next;
        end
    end
    
    always @* begin
        q_next = q;
        
        if (byteena[0]) begin
            q_next[7:0] = d[7:0];
        end
        if (byteena[1]) begin
            q_next[15:8] = d[15:8];
        end 
    end
endmodule
