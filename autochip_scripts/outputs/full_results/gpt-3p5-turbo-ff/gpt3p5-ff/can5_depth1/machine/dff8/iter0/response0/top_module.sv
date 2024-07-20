module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);
    
    reg [7:0] register;
    
    initial begin
        register = 8'h0;
    end

    always @(posedge clk)
        register <= d;

    assign q = register;
    
endmodule
