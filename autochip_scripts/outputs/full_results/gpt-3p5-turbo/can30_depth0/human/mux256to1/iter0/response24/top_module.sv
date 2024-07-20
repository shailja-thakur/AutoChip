module top_module (
    input [255:0] in,
    input [7:0] sel,
    output out
);

reg [255:0] mux_output;

always @(*) begin
    case(sel)
        8'b00000000: mux_output = in[0];
        8'b00000001: mux_output = in[1];
        8'b00000010: mux_output = in[2];
        8'b00000011: mux_output = in[3];
        8'b00000100: mux_output = in[4];
        8'b00000101: mux_output = in[5];
        8'b00000110: mux_output = in[6];
        8'b00000111: mux_output = in[7];
        // Add remaining cases for inputs 8 to 255
        default: mux_output = 1'b0;
    endcase
end

assign out = mux_output;

endmodule
