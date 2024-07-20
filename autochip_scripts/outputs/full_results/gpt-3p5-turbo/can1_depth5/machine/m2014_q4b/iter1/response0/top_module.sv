module top_module (
    input wire clk,
    input wire d,
    input wire ar,
    output reg q
);
    
    always @(posedge clk, posedge ar)
    begin
        if (ar)
            q <= 0;
        else
            q <= d;
    end
    
endmodule
