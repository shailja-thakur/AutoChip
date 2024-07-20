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
    end else if (count != 0) begin
        count <= count - 1;
        tc <= 0; // Reset tc to 0 when count is decremented
    end
    if (count == 1) begin
        tc <= 1; // Set tc to 1 when count reaches 1
    end
end

endmodule
