module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

reg [255:0] in_mux [0:255];
integer i;

always @(in, sel) begin
    for(i = 0; i < 256; i = i + 1) begin
        in_mux[i] = in[4*i +: 4];
    end
    
    case(sel)
        0: out = in_mux[0];
        1: out = in_mux[1];
        2: out = in_mux[2];
        3: out = in_mux[3];
        4: out = in_mux[4];
        5: out = in_mux[5];
        6: out = in_mux[6];
        7: out = in_mux[7];
        default: out = 4'b0;
    endcase
end

endmodule
