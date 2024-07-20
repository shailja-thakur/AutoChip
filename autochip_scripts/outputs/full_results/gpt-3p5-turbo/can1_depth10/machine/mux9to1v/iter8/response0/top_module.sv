module top_module (
    input [15:0] a,
    input [15:0] b,
    input [15:0] c,
    input [15:0] d,
    input [15:0] e,
    input [15:0] f,
    input [15:0] g,
    input [15:0] h,
    input [15:0] i,
    input [3:0] sel,
    output logic [15:0] out
);

    assign out = (sel == 4'b0000) ? a :
                 (sel == 4'b0001) ? b :
                 (sel == 4'b0010) ? c :
                 (sel == 4'b0011) ? d :
                 (sel == 4'b0100) ? e :
                 (sel == 4'b0101) ? f :
                 (sel == 4'b0110) ? g :
                 (sel == 4'b0111) ? h :
                 (sel == 4'b1000) ? i :
                 16'b1;
    
endmodule
