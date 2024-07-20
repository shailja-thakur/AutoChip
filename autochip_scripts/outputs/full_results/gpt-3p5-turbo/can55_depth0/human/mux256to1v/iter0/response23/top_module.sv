module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

reg [255:0] mux_inputs [0:255]; // creating an array of 256 4-bit inputs

genvar i;
generate
    for (i = 0; i < 256; i = i + 1) begin
        assign mux_inputs[i] = in[i*4 +: 4];
    end
endgenerate

always @* begin
    case (sel)
        0: out = mux_inputs[0];
        1: out = mux_inputs[1];
        2: out = mux_inputs[2];
        // Add cases for sel values 3 through 255
        default: out = 4'b0;
    endcase
end

endmodule
