module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case (x)
        4'b00??: f = 0;
        4'b01??, 4'b1000: f = 1;
        4'b110?, 4'b111?: f = 1;
        default: f = 0;
    endcase
end

endmodule
