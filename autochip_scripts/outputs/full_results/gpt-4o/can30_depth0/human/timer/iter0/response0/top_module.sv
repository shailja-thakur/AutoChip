module top_module(
    input clk,
    input load,
    input [9:0] data,
    output tc
);
    
    reg [9:0] count;
    assign tc = (count == 10'b0);

    always @(posedge clk) begin
        if (load) begin
            count <= data;
        end else if (count != 10'b0) begin
            count <= count - 1'b1;
        end
    end

endmodule
