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
        tc <= 0;
    end
    else if (count > 0) begin
        count <= count - 1;
        tc <= (count == 1);
    end
    else begin
        tc <= 1;
    end
end

endmodule
