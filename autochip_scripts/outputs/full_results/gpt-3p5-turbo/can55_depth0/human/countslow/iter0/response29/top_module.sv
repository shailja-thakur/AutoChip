module top_module(
    input clk,
    input slowena,
    input reset,
    output reg [3:0] q);
    
    reg [3:0] q_next;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;
        end else if (slowena) begin
            q <= q_next;
        end
    end
    
    always @(posedge clk) begin
        if (reset) begin
            q_next <= 4'b0000;
        end else if (q == 4'b1001) begin
            q_next <= 4'b0000;
        end else begin
            q_next <= q + 1;
        end
    end

endmodule
