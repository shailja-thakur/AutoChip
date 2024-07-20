module top_module(
    input clk,
    input load,
    input [9:0] data,
    output tc
);

    reg [9:0] count;
    reg tc;
    
    always @(posedge clk) begin
        if (load) begin
            count <= data;
        end else if (count > 0) begin
            count <= count - 1;
        end
    end
    
    always @(*) begin
        if (count == 0) begin
            tc = 1;
        end else begin
            tc = 0;
        end
    end
    
endmodule
