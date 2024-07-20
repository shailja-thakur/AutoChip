module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    // Implementing the truth table using logic gates
    // OR gates for each minterm
    wire minterm_0 = a & (~b) & (~c) & d;
    wire minterm_1 = a & (~b) & (~c) & (~d);
    wire minterm_2 = (~a) & (~b) & c & d;
    wire minterm_3 = a & (~b) & c & d;
    wire minterm_4 = a & (~b) & (~c) & d;
    wire minterm_5 = (~a) & b & c & d;
    wire minterm_6 = a & b & (~c) & d;
    wire minterm_7 = b & c & d;
    
    // OR gate for each row of minterms
    wire row_0 = minterm_0 | minterm_1;
    wire row_1 = minterm_2 | minterm_3;
    wire row_2 = minterm_4 | minterm_5;
    wire row_3 = minterm_6 | minterm_7;
    
    // OR gate for the entire circuit
    assign out = row_0 | row_1 | row_2 | row_3;
endmodule
