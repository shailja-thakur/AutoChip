module top_module (
	input [1023:0] in,
	input [7:0] sel,
	output [3:0] out
);

wire [255:0] sel_in [7:0];
wire [3:0] sel_out [7:0];

// Split the input into 256 4-bit vectors
generate
    genvar i;
    for(i=0;i<256;i=i+1) begin : VECTOR_SPLIT
        assign sel_in[i] = in[i*4 +: 4];
    end
endgenerate

// Use the multiplexer to select the output
generate
    genvar i;
    for(i=0;i<256;i=i+1) begin : MUX_SELECT
        mux4 #(4) mux (
            .in0(sel_in[i][0]),
            .in1(sel_in[i][1]),
            .in2(sel_in[i][2]),
            .in3(sel_in[i][3]),
            .sel(sel[2:0]),
            .out(sel_out[i])
        );
    end
endgenerate

// Concatenate the selected outputs
assign out = {sel_out[7], sel_out[6], sel_out[5], sel_out[4], sel_out[3], sel_out[2], sel_out[1], sel_out[0]};

endmodule
module mux4 #(parameter WIDTH=4) (
    input [WIDTH-1:0] in0,
    input [WIDTH-1:0] in1,
    input [WIDTH-1:0] in2,
    input [WIDTH-1:0] in3,
    input [2:0] sel,
    output reg [WIDTH-1:0] out
);
always @* begin
    case(sel)
        3'b000: out = in0;
        3'b001: out = in1;
        3'b010: out = in2;
        3'b011: out = in3;
        default: out = in0;
    endcase
end

endmodule
