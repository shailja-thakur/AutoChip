module top_module (
    input [4:1] x,
    output logic f
);

always @(*) begin
    case (x)
        4'b0000, 4'b0011, 4'b0100, 4'b1110, 4'b1011, 4'b1000, 4'b1010: f = 1;
        default: f = 0;
    endcase
end

endmodule
