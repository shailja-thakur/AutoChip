module top_module (
    input a,
    input b,
    input c,
    input d,
    output out_sop,
    output out_pos
);

    // Define all the possible input combinations 
    parameter INPUT_0 = 4'b0000; // Represents 0
    parameter INPUT_1 = 4'b0001; // Represents 1
    parameter INPUT_4 = 4'b0100; // Represents 4
    parameter INPUT_5 = 4'b0101; // Represents 5
    parameter INPUT_6 = 4'b0110; // Represents 6
    parameter INPUT_9 = 4'b1001; // Represents 9
    parameter INPUT_10 = 4'b1010; // Represents 10
    parameter INPUT_13 = 4'b1101; // Represents 13
    parameter INPUT_14 = 4'b1110; // Represents 14

    // Define the output logic
    assign out_sop = ((a & b & c & d) ||         // Input 15 = 4'b1111
                     (a & ~b & ~c & ~d) ||      // Input 2 = 4'b0010
                     (a & ~b & c & d));         // Input 7 = 4'b0111
    
    assign out_pos = ((~a & ~b & ~c & ~d) ||                  // Input 0 = 4'b0000
                     (~a & b & ~c & ~d) ||                   // Input 1 = 4'b0001
                     (~a & ~b & ~c & d) ||                   // Input 4 = 4'b0100
                     (~a & b & ~c & d) ||                    // Input 5 = 4'b0101
                     (~a & b & c & ~d) ||                    // Input 6 = 4'b0110
                     (~a & ~b & ~c & ~d) ||                  // Input 9 = 4'b1001
                     (~a & b & c & d) ||                     // Input 10 = 4'b1010
                     (~a & ~b & ~c & d) ||                   // Input 13 = 4'b1101
                     (~a & ~b & c & d));                     // Input 14 = 4'b1110

endmodule
