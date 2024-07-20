module top_module (
    input [4:1] x,
    output logic f
);

logic [3:0] k_map;

always_comb begin
    case (x)
        4'b00_00: k_map = 1'b1;
        4'b00_01: k_map = 1'b0;
        4'b00_11: k_map = 1'b0;
        4'b00_10: k_map = 1'b1;
        4'b01_00: k_map = 1'b0;
        4'b01_01: k_map = 1'b0;
        4'b01_11: k_map = 1'b0;
        4'b01_10: k_map = 1'b0;
        4'b11_00: k_map = 1'b1;
        4'b11_01: k_map = 1'b1;
        4'b11_11: k_map = 1'b1;
        4'b11_10: k_map = 1'b0;
        4'b10_00: k_map = 1'b1;
        4'b10_01: k_map = 1'b1;
        4'b10_11: k_map = 1'b0;
        4'b10_10: k_map = 1'b1;
        default: k_map = 1'b0;
    endcase

    f = k_map;
end

endmodule
