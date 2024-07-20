module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

// Corrected module definition
    wire [255:0] in_select; // intermediate wire to select the 4-bit input
    
    assign in_select = in[sel*4 +: 4]; // selecting the appropriate 4-bit input from the packed input
    
    assign out = in_select;

endmodule
