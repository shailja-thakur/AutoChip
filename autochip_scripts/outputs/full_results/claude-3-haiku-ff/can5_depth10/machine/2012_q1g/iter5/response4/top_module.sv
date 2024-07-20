module top_module (
    input [4:0] x,
    output logic f
);

always_comb begin
    case (x)
        5'h0, 5'h1, 5'h2, 5'h3, 5'h4, 5'h5, 5'h6, 5'h7, 5'h8, 5'h9, 5'ha, 5'hb, 5'hc, 5'hd, 5'he, 5'hf: f = 1'b1;
        default: f = 1'b0;
    endcase
end

endmodule
