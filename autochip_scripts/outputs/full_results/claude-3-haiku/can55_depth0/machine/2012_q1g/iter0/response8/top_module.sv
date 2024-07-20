module top_module (
    input [4:0] x,
    output logic f
);

always_comb begin
    case (x)
        5'h0, 5'h1, 5'h4, 5'h5, 5'h6, 5'hC, 5'hE, 5'hF: f = 1'b1;
        5'h2, 5'h3, 5'h7, 5'h8, 5'h9, 5'hA, 5'hB, 5'hD: f = 1'b0;
        default: f = 1'bx;
    endcase
end

endmodule
