module top_module(
    input clk,
    input [7:0] d,
    input areset,
    output reg [7:0] q);
    
    always @(posedge clk or posedge areset) begin
        if (areset)
            q <= 8'b0; // Reset q to 0 if areset is high
        else
            q <= d; // Otherwise, set q to d
    end
    
endmodule
