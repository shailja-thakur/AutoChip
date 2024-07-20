module top_module(
	input clk,
	input [7:0] d,
	output reg [7:0] q);

    reg [7:0] q_reg; // register to store the output values
    
    always @(posedge clk)
    begin
        q_reg <= d; // update the register with the input values on positive edge of clk
    end
    
    assign q = q_reg; // assign the register value to the output q
    
endmodule
