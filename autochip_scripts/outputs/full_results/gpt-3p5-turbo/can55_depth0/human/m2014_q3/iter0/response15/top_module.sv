module top_module (
    input [4:1] x,
    output logic f
);
    
    always_comb
        case (x)
            4'b00?? : f = x[3] & ~x[4];
            4'b01?? : f = (x[3] & x[4]) | (~x[4]);
            4'b11?? : f = (x[3] & x[4]);
            4'b10?? : f = (x[4] & ~x[3]);
        endcase
        
endmodule
