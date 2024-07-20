module top_module (
    input [4:1] x,
    output logic f
);

logic [1:0] x1_x2;
logic [1:0] x3_x4;

assign x1_x2 = x[2:1];
assign x3_x4 = x[4:3];

always_comb begin
    case({x3_x4, x1_x2})
        2'b00_00: f = 1'b1;
        2'b00_01: f = 1'b0;
        2'b00_11: f = 1'b0;
        2'b00_10: f = 1'b1;
        2'b01_00: f = 1'b0;
        2'b01_01: f = 1'b0;
        2'b01_11: f = 1'b0;
        2'b01_10: f = 1'b0;
        2'b11_00: f = 1'b1;
        2'b11_01: f = 1'b1;
        2'b11_11: f = 1'b1;
        2'b11_10: f = 1'b0;
        2'b10_00: f = 1'b1;
        2'b10_01: f = 1'b1;
        2'b10_11: f = 1'b0;
        2'b10_10: f = 1'b1;
    endcase
end

endmodule
