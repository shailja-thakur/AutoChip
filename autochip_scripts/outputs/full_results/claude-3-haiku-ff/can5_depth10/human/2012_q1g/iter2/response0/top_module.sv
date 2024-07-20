module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4:3], x[2:1]})
        6'b000_01: f = 1'b1;
        6'b001_00: f = 1'b0;
        6'b011_xx: f = 1'b1;
        6'b100_01: f = 1'b1;
        default: f = 1'b0;
    endcase
end

endmodule
