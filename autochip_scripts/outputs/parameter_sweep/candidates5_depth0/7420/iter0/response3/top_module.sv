module top_module(
    input p1a, 
    input p1b, 
    input p1c, 
    input p1d, 
    output p1y, 
    input p2a, 
    input p2b, 
    input p2c, 
    input p2d, 
    output p2y
);
    // Internal wires
    wire nand1_out, nand2_out;
  
    // NAND gate 1
    nand_gate nand1 (.a(p1a), .b(p1b), .c(p1c), .d(p1d), .out(nand1_out));
  
    // NAND gate 2
    nand_gate nand2 (.a(p2a), .b(p2b), .c(p2c), .d(p2d), .out(nand2_out));  
  
    // Output assignments
    assign p1y = nand1_out;
    assign p2y = nand2_out;

    // 4-input NAND gate
    module nand_gate(
        input a, 
        input b, 
        input c, 
        input d, 
        output out
    );
        assign out = ~(a & b & c & d);
    endmodule
