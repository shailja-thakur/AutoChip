module top_module (
    input [2:0] in,
    output [1:0] out
);

    // Declare internal signals
    wire [2:0] count;
    
    // Instantiate a module to count the number of 1's
    popcount3 u1 (
        .in(in),
        .out(count)
    );
    
    // Assign the 2-bit output based on the 3-bit count
    assign out = (count == 3'b000) ? 2'b00 :
                 (count == 3'b001) ? 2'b01 :
                 (count == 3'b010) ? 2'b01 :
                 (count == 3'b011) ? 2'b10 :
                 (count == 3'b100) ? 2'b10 :
                 (count == 3'b101) ? 2'b11 :
                 (count == 3'b110) ? 2'b11 :
                 2'b11;
    
endmodule
module popcount3 (
    input [2:0] in,
    output [2:0] out
);
    
    assign out = in[0] + in[1] + in[2];
    
endmodule
