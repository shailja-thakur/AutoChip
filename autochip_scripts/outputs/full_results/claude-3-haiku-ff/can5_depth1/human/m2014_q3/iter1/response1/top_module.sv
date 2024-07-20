module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case({x[4:3], x[2:1]})
        4'b0001: f = 1'b0;
        4'b0111: f = 1'b1;
        4'b1101: f = 1'b1;
        4'b1111: f = 1'b1;
        default: f = 1'bx; // Don't care condition
    endcase
end

endmodule
