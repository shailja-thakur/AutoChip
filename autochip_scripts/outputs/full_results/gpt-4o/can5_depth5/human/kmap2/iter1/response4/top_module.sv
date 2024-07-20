module top_module (
    input a, 
    input b,
    input c,
    input d,
    output out
);
    
    // Implementing the Karnaugh map as a SOP expression
    assign out = (~a & ~b & ~c & ~d) |  // Cell 0000
                 (~a & ~b & ~c & d)  |  // Cell 0001
                 (~a & ~b & d & ~c)  |  // Cell 0010
                 (~a & ~b & d & c)   |  // Cell 0011
                 (~a & d & ~c & ~b)  |  // Cell 0100
                 (a & b & ~c & ~d)   |  // Cell 1000
                 (a & ~b & ~c & ~d)  |  // Cell 1001
                 (a & b & d & ~c)    |  // Cell 1010
                 (a & d & b & c);       // Cell 1111

endmodule
