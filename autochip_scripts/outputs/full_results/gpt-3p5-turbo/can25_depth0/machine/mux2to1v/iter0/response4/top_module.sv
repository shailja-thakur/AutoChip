module top_module (
    input [99:0] a,
    input [99:0] b,
    input sel,
    output [99:0] out
);
    
    always @ (a, b, sel)
    begin
        if (sel == 1'b0)
            out = a;
        else if (sel == 1'b1)
            out = b;
        else
            out = 100'b0; // Default output value
    end

endmodule
