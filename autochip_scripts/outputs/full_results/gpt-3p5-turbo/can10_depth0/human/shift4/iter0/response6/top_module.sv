module top_module(
    input clk,
    input areset,
    input load,
    input ena,
    input [3:0] data,
    output reg [3:0] q);
    
    reg [3:0] temp; // temporary register
    
    always @(posedge clk, posedge areset) begin
        if (areset)
            temp <= 4'b0000; // reset shift register to zero
        else if (load)
            temp <= data; // load data into shift register
        else if (ena)
            temp <= {temp[2:0], 1'b0}; // shift right
            
        q <= temp; // output contents of shift register
    end
endmodule
