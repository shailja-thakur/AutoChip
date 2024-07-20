module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output reg tc
);
    reg [9:0] count;
    
    always @(posedge clk) begin
        if (load)
            count <= data;
        else if (count != 10'd0)
            count <= count - 1;
    end
    
    always @(count) begin
        if (count == 10'd0)
            tc = 1;
        else
            tc = 0;
    end
endmodule
