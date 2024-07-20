module top_module(
    input [4:0] x,
    output logic f
);

    always_comb begin
        case(x)
            4'h0, 4'h1, 4'h4, 4'h5, 4'h6, 4'hc, 4'he: f = 1;
            4'h2, 4'h3, 4'h7, 4'h8, 4'h9, 4'ha, 4'hb, 4'hd: f = 0;
            default: f = 0;
        endcase
    end

endmodule
