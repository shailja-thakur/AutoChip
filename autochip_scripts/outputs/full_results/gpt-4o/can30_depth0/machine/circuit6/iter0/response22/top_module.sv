module top_module (
    input [2:0] a, 
    output reg [15:0] q
);

    always @(*) begin
        case(a)
            3'h0: q = 16'd4658;
            3'h1: q = 16'd44768;
            3'h2: q = 16'd10196;
            3'h3: q = 16'd23054;
            3'h4: q = 16'd8294;
            3'h5: q = 16'd25806;
            3'h6: q = 16'd50470;
            3'h7: q = 16'd12057;
            default: q = 16'd0; // Default case to handle any unexpected input
        endcase
    end
endmodule
