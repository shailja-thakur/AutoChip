module top_module(
    input [3:1] y,
    input w,
    output reg Y2);
    
    always @ (*)
    begin
        case(y)
            3'b000: if(w==1) Y2 = 1; else Y2 = 0; // A
            3'b001: if(w==1) Y2 = 0; else Y2 = 0; // B
            3'b010: if(w==1) Y2 = 0; else Y2 = 0; // C
            3'b011: if(w==1) Y2 = 0; else Y2 = 0; // D
            3'b100: if(w==1) Y2 = 0; else Y2 = 1; // E
            3'b101: if(w==1) Y2 = 1; else Y2 = 0; // F
            default: Y2 = 0;
        endcase
    end
    
endmodule
