module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);
    reg [3:0] in_shifted; // Shifted input vector
    assign out_both[0] = in[0] & in_shifted[3];
    assign out_both[1] = in[1] & in[0];
    assign out_both[2] = in[2] & in[1];
    assign out_any[1] = in[1] | in[0]; 
    assign out_any[2] = in[2] | in[1];
    assign out_any[3] = in[3] | in[2];
    assign out_different[0] = in[0] != in_shifted[3];
    assign out_different[1] = in[1] != in[0];
    assign out_different[2] = in[2] != in[1];
    assign out_different[3] = in[3] != in[2];
    always @(*) begin
        in_shifted[3] = in[3];
        in_shifted[2] = in[2];
        in_shifted[1] = in[1];
        in_shifted[0] = in[0];
    end
endmodule
