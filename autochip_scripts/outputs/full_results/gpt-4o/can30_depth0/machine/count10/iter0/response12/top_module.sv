module top_module(
    input clk,
    input reset,
    output reg [3:0] q
);
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;
        end else if (q == 4'b1001) begin // Check if q is equal to 9
            q <= 4'b0000;
        end else begin
            q <= q + 1'b1;
        end
    end
    
endmodule
