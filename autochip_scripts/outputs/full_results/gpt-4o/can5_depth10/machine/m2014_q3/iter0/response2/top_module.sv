module top_module (
    input [3:0] x,  // Changing input width to 4 bits as the hexadecimal values range from 4'h0 to 4'hf
    output logic f
);

    always_comb begin
        case (x)
            4'h0, 
            4'h1, 
            4'h3, 
            4'h5, 
            4'hA, 
            4'hD, 
            4'hF: f = 1'bx;
            4'h2: f = 1'b0;
            4'h4, 
            4'h6, 
            4'hB, 
            4'hC, 
            4'hE: f = 1'b1;
            4'h7, 
            4'h8, 
            4'h9: f = 1'b0;
            default: f = 1'bx; // Default case to handle any unexpected input
        endcase
    end

endmodule
