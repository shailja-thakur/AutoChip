module top_module (
    input [15:0] a,
    input [15:0] b,
    input [15:0] c,
    input [15:0] d,
    input [15:0] e,
    input [15:0] f,
    input [15:0] g,
    input [15:0] h,
    input [15:0] i,
    input [3:0] sel,
    output logic [15:0] out
);

reg [15:0] mux_out;

always @*
begin
    case (sel)
        4'b0000: mux_out = a;
        4'b0001: mux_out = b;
        4'b0010: mux_out = c;
        4'b0011: mux_out = d;
        4'b0100: mux_out = e;
        4'b0101: mux_out = f;
        4'b0110: mux_out = g;
        4'b0111: mux_out = h;
        4'b1000: mux_out = i;
        default: mux_out = 16'b1111_1111_1111_1111;
    endcase
end

assign out = mux_out;

endmodule
