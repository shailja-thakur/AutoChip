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
    end
    else if (count != 0) begin
        count <= count - 1;
        tc <= 0; // clear tc when count is decremented
    end
    else begin
        tc <= 1; // set tc when count reaches 0
    end
end

endmodule
