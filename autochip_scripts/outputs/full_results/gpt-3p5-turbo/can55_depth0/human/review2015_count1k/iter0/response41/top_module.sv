module top_module(
    input clk,
    input reset,
    output reg [9:0] q);
        
    reg [9:0] count;
    
    always @(posedge clk) begin
        if (reset) begin
            count <= 10'b0;
        end else if (count == 10'd999) begin
            count <= 10'b0;
        end else begin
            count <= count + 10'd1;
        end
    end
    
    assign q = count;

endmodule
