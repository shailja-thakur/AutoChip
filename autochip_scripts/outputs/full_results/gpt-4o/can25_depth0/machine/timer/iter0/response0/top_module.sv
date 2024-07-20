module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output reg tc
);
    reg [9:0] count;

    always @(posedge clk) begin
        if (load) begin
            count <= data;
        end else if (count != 10'd0) begin
            count <= count - 10'd1;
        end
    end

    always @(*) begin
        tc = (count == 10'd0);
    end
endmodule
