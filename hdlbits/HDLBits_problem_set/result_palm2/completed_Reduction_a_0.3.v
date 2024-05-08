module top_module (
    input [7:0] in,
    output parity); 
    
    xor4 xor1 (
        input [3:0] a,
        input [3:0] b,
        output reg c);
    
    xor4 xor2 (
        input [3:0] c,
        input [3:0] d,
        output reg e);
    
    xor4 xor3 (
        input [3:0] e,
        input [3:0] f,
        output reg g);
    
    xor4 xor4 (
        input [3:0] g,
        input [3:0] h,
        output reg parity);
    
    assign parity = xor4.out;
    
endmodule