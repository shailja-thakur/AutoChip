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
    else if (count > 0)
        count <= count - 1;
end

always @(*) begin
    if (count == 0)
        tc = 1;
    else
        tc = 0;
end

endmodule
