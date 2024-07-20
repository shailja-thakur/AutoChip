module top_module (
    input c,
    input d,
    output reg [3:0] mux_in
);

reg [1:0] ab;

always @ (c or d)
begin
    if (c == 0 && d == 0)
        ab = 2'b00;
    else if (c == 0 && d == 1)
        ab = 2'b01;
    else if (c == 1 && d == 1)
        ab = 2'b11;
    else if (c == 1 && d == 0)
        ab = 2'b10;
end

always @ (ab)
begin
    case (ab)
        2'b00: mux_in = 4'b0001;
        2'b01: mux_in = 4'b1000;
        2'b11: mux_in = 4'b1011;
        2'b10: mux_in = 4'b1001;
    endcase
end

endmodule
