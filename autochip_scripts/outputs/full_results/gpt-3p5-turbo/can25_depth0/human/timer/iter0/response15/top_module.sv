module top_module(
    input clk, 
    input load, 
    input [9:0] data, 
    output tc
);

reg [9:0] count;

always @(posedge clk) begin
    if (load) begin
        count <= data;
    end else if (count > 0) begin
        count <= count - 1;
    end
end

assign tc = (count == 0);

endmodule
