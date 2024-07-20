module top_module(
    input [7:0] p1,
    output p1y,
    input [7:0] p2,
    output p2y
);
    
    // Internal wire declarations
    wire [3:0] nand1_out;
    wire [3:0] nand2_out;
    
    // Internal NAND gate instances
    nand4 #(.WIDTH(4)) nand1 (p1a, p1b, p1c, p1d, nand1_out);
    nand4 #(.WIDTH(4)) nand2 (p2a, p2b, p2c, p2d, nand2_out);
    
    // Output assignment
    assign p1y = &nand1_out;
    assign p2y = &nand2_out;
    
endmodule
module nand4(
    input [3:0] a,
    output y
);
    
    // Internal wire declarations
    wire [2:0] nand1_out;
    wire [1:0] nand2_out;
    wire         nand3_out;
    
    // Internal NAND gate instances
    nand nand1 (a[0], a[1], nand1_out[0]);
    nand nand2 (a[2], a[3], nand1_out[1]);
    nand nand3 (nand1_out[0], nand1_out[1], nand2_out[0]);
    nand nand4 (nand2_out[0], nand2_out[0], nand3_out);
    
    // Output assignment
    assign y = nand3_out;
    
endmodule
