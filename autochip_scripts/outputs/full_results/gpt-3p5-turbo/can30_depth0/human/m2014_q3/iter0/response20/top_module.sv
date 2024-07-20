module top_module (
	input [4:1] x,
	output logic f
);

always_comb begin
    case (x)
        4'b00-00: f = 0;
        4'b00-01: f = 0;
        4'b00-10: f = 1;
        4'b00-11: f = 1;
        4'b01-00: f = 0;
        4'b01-01: f = 0;
        4'b01-10: f = 1;
        4'b01-11: f = 0;
        4'b10-00: f = 1;
        4'b10-01: f = 1;
        4'b10-10: f = 0;
        4'b10-11: f = 1;
        4'b11-00: f = 1;
        4'b11-01: f = 1;
        4'b11-10: f = 0;
        4'b11-11: f = 1;
    endcase
end

endmodule
