module top_module (
    input [4:1] x,
    output logic f
);
    always_comb begin
        case(x)
            4'h0: f = 1'bx;
            4'h1: f = 1'bx;
            4'h2: f = 1'b0;
            4'h3: f = 1'bx;
            4'h4: f = 1'b1;
            4'h5: f = 1'bx;
            4'h6: f = 1'b1;
            4'h7: f = 1'b0;
            4'h8: f = 1'b0;
            4'h9: f = 1'b0;
            4'hA: f = 1'bx;
            4'hB: f = 1'b1;
            4'hC: f = 1'b1;
            4'hD: f = 1'bx;
            4'hE: f = 1'b1;
            4'hF: f = 1'bx;
            default: f = 1'bx;
        endcase
    end
endmodule
