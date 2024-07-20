module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3], x[2], x[1]})
        4'b0000, 4'b0010, 4'b0110, 4'b0111, 4'b1010, 4'b1011: f = 1'b0;
        4'b0101, 4'b1000, 4'b1001: f = 1'b1;
        default: f = 1'b1; // Assign any value for don't-care conditions
    endcase
end

endmodule
