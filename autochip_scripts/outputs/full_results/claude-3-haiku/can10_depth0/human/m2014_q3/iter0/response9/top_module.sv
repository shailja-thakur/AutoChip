module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3], x[2], x[1]})
        4'b0001: f = 0;
        4'b0011: f = 1;
        4'b0111: f = 1;
        4'b1001: f = 1;
        4'b1010: f = 0;
        4'b1100: f = 0;
        default: f = 1; // Treat don't-care as 1
    endcase
end

endmodule
