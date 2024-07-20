module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3], x[2], x[1]})
        4'b1000: f = 1;
        4'b0010: f = 1;
        4'b1110: f = 1;
        4'b1011: f = 1;
        default: f = 0;
    endcase
end

endmodule
