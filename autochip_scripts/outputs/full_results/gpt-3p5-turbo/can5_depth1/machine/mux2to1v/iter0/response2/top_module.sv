module top_module (
    input [99:0] a,
    input [99:0] b,
    input sel,
    output [99:0] out
);
    
    // Use assign statement to assign the selected input to the output
    assign out = sel ? b : a;
    
endmodule
