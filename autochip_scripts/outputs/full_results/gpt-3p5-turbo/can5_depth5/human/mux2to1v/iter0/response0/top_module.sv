module top_module (
    input [99:0] a,
    input [99:0] b,
    input sel,
    output [99:0] out
);

    // Create internal wire for selecting the output
    wire [99:0] selected_output;
    
    // Implement the 2-1 multiplexer
    assign selected_output = sel ? b : a;
    
    // Assign the selected output to the module output
    assign out = selected_output;
    
endmodule
