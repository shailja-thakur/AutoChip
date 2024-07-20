module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3], x[2], x[1]})
        4'b0001: f = 0;
        4'b0011: f = 1;
        4'b0111: f = 1;
        4'b1011: f = 1;
        4'b1111: f = 1;
        4'b1100: f = 0;
        default: f = 1; // This covers the don't-care cases
    endcase
end

endmodule
