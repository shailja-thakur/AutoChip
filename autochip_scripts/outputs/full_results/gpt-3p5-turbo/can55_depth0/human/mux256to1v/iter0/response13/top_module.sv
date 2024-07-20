module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

wire [255:0] temp_out;

// 256-to-1 multiplexer
genvar i;
generate
    for (i = 0; i < 256; i = i + 1) begin: mux_gen
        mux4_mux #(4) mux (
            .in({in[((i+1)*4)-1:i*4]}),
            .sel(sel),
            .out(temp_out[i])
        );
    end
endgenerate

// Output selection
always @(*) begin
    case (sel)
        0: out = temp_out[0];
        1: out = temp_out[1];
        2: out = temp_out[2];
        // ... Add more cases up to 255
    endcase
end

endmodule
module mux4_mux(
    input [3:0] in,
    input [7:0] sel,
    output reg out
);
    always @(*) begin
        case (sel)
            0: out = in[0];
            1: out = in[1];
            2: out = in[2];
            3: out = in[3];
        endcase
    end
endmodule
