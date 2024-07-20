module top_module(
    input clk,
    input reset,
    output reg [3:0] q);
    
    always @(posedge clk or posedge reset) begin
        if (reset) // check if reset is active high
            q <= 4'b0001; // reset the counter to 1
        else if (q == 4'b1010)
            q <= 4'b0001; // reset the counter to 1 after reaching 10
        else
            q <= q + 1; // increment the counter
    end
    
endmodule
