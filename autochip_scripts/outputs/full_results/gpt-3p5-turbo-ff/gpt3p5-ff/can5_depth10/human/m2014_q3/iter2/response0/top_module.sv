module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[3], x[4], x[2], x[1]})
        4'b00??: f = 0;
        4'b01??: f = 1;
        4'b11??, 4'b10??: f = 1;
        default: f = 0;
    endcase
end

endmodule
