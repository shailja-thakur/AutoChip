module top_module (
    input [4:0] x,
    output logic f
);

always_comb begin
    case (x)
        5'h00, 5'h01, 5'h04, 5'h05, 5'h06, 5'h07, 5'h08, 5'h09, 5'h0a, 5'h0b, 5'h0c, 5'h0d, 5'h0e, 5'h0f: f = 1'b1;
        default: f = 1'b0;
    endcase
end

endmodule
