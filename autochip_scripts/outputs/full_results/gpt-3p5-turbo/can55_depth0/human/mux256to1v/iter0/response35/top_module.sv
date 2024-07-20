module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

reg [255:0] mux_out;  // create a 256-bit register to store the selected input

always @ (*) begin
    case (sel)
        3'b000: mux_out = in[3:0];  // select bits in[3:0]
        3'b001: mux_out = in[7:4];  // select bits in[7:4]
        3'b010: mux_out = in[11:8];  // select bits in[11:8]
        // continue with cases for selecting bits in[15:12], in[19:16], etc.
        // ...
        default: mux_out = in[1023:1020];  // select bits in[1023:1020] as default
    endcase
end

assign out = mux_out[3:0];  // assign the selected bits to the output

endmodule
