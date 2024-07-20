module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'bxx11: f = 1;
        4'bxxxx: f = 1;
        default: f = 0;
    endcase
end

endmodule
