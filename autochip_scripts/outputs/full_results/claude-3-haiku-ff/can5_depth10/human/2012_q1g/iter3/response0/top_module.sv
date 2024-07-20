module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4:3], x[2:1]})
        6'b000001: f = 1'b1;
        6'b000011: f = 1'b0;
        6'b000010: f = 1'b1;
        6'b001111: f = 1'b1;
        6'b001110: f = 1'b1;
        6'b011000: f = 1'b1;
        6'b010001: f = 1'b1;
        default: f = 1'b0;
    endcase
end

endmodule
