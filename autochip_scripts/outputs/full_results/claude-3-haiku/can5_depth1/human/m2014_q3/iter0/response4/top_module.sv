module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4:3], x[2:1]})
        4'b0000, 4'b0010, 4'b1100, 4'b1110: f = 1'b0;
        4'b0101: f = 1'b0;
        4'b0111: f = 1'b1;
        4'b1001, 4'b1011: f = 1'b1;
        default: f = 1'b0; // Assign don't-care (d) to 0
    endcase
end

endmodule
