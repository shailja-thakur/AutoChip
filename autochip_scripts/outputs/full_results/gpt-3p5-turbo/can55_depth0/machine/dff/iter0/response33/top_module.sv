module top_module(
    input clk,
    input wire d,
    output reg q
);
    
    initial begin
        q = 1'hx; // Set initial value of register q to 1'hx
    end
    
    always @(posedge clk) begin
        q <= d; // Assign value of input d to register q on the rising edge of clk
    end

endmodule
