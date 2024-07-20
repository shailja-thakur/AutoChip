module top_module(
    input clk,
    input [7:0] d,
    output reg [7:0] q);

    reg [7:0] regD;
	
    always @(posedge clk) begin
        regD <= d;
        q <= regD;
    end
	
    initial begin
        regD <= 8'b00000000;
        q <= 8'b00000000;
    end
	
endmodule
