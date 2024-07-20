module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3], x[2], x[1]})
        4'b0001, 4'b0011, 4'b1000, 4'b1001: f = 1'b1;
        4'b0010, 4'b0100, 4'b1011: f = 1'b0;
        default: f = 1'b0; // Since d (don't-care) can be assigned any value, we choose 0 for convenience
    endcase
end

endmodule
