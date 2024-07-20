module top_module (
    input sel,
    input [7:0] a,
    input [7:0] b,
    output [7:0] out
);
    
    always @(*) begin
        if (sel == 0)
            out = b;
        else if (sel == 1)
            out = a;
    end
    
endmodule
