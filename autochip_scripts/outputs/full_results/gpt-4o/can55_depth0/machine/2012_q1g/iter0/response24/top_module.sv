module top_module (
    input [4:0] x,
    output logic f
);
    always_comb begin
        case (x)
            5'd0: f = 1;
            5'd1: f = 1;
            5'd2: f = 0;
            5'd3: f = 0;
            5'd4: f = 1;
            5'd5: f = 1;
            5'd6: f = 1;
            5'd7: f = 0;
            5'd8: f = 0;
            5'd9: f = 0;
            5'd10: f = 0;
            5'd11: f = 0;
            5'd12: f = 1;
            5'd13: f = 0;
            5'd14: f = 1;
            5'd15: f = 1;
            default: f = 0; // default case for completeness
        endcase
    end
endmodule
