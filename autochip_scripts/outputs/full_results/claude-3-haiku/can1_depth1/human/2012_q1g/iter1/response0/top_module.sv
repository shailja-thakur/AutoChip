module top_module (
    input [4:1] x,
    output logic f
);

always_comb begin
    case ({x[4], x[3]})
        2'b00, 2'b10: f = x[2] & ~x[1];
        2'b11: f = 1'b1;
        default: f = 1'b0;
    endcase
end

endmodule
