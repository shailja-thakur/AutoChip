module top_module (
    input [3:0] x,
    output logic f
);

always_comb begin
    case (x)
        4'h0, 4'h1, 4'h3, 4'h5, 4'ha, 4'hd, 4'hf: f = 1'bx;
        4'h2, 4'h7, 4'h8, 4'h9: f = 1'b0;
        4'h4, 4'h6, 4'hb, 4'hc, 4'he: f = 1'b1;
    endcase
end

endmodule
