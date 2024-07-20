module top_module (
    input [4:1] x,
    output logic f
);
    
    always_comb begin
        case (x)
            4'b0001, 4'b0011, 4'b0110, 4'b1001, 4'b1010, 4'b1101, 4'b1110: f = 0;
            4'b0101, 4'b0111, 4'b1111: f = 1;
            default: f = 1;  // Handling don't-care conditions (d)
        endcase
    end
    
endmodule
