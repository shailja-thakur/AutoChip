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
    end
    tc <= (count == 1); // Corrected the condition to check for count == 1
end

endmodule
