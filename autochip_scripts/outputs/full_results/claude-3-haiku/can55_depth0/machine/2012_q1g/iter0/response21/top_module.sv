module top_module (
    input [4:0] x,
    output logic f
);

always_comb begin
    case (x)
        5'd0, 5'd1, 5'd4, 5'd5, 5'd6, 5'd14, 5'd15: f = 1'b1;
        5'd2, 5'd3, 5'd7, 5'd8, 5'd9, 5'd10, 5'd11, 5'd13: f = 1'b0;
        default: f = 1'b0;
    endcase
end

endmodule
