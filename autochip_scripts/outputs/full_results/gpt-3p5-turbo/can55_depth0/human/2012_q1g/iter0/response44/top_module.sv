module top_module (
    input [4:1] x,
    output logic f
);
    always_comb begin
        case ({x[3], x[4]})
            2'b00: f = 1;
            2'b01: f = 0;
            2'b10: f = 1;
            2'b11: f = 0;
        endcase
    end
endmodule
