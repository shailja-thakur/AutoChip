module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x})
        8'b0001_0000: f = 0;
        8'b0011_0001: f = 1;
        8'b0101_0011: f = 1;
        8'b0111_0001: f = 0;
        8'b1001_0000: f = 1;
        8'b1011_0001: f = 1;
        default: f = 1; // Don't care
    endcase
end

endmodule
