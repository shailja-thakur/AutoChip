module top_module(
    input [3:0] y,  // The 'y' input corrected to 4 bits as per the error message
    input w,        // The 'w' input should be 1 bit
    output reg Y2); // The Y2 output defined as a reg

    always @(*) begin
        case (y)
            4'h0: Y2 = 0;
            4'h1: Y2 = 0;
            4'h2: Y2 = 1;
            4'h3: Y2 = 1;
            4'h4: Y2 = 0;
            4'h5: Y2 = 1;
            4'h6: Y2 = 0;
            4'h7: Y2 = 0;
            4'h8: Y2 = 0;
            4'h9: Y2 = 1;
            4'hA: Y2 = 1;
            4'hB: Y2 = 1;
            default: Y2 = 0; // Default case to handle unspecified inputs
        endcase
    end

endmodule
