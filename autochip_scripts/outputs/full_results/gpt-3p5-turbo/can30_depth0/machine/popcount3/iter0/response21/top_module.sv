module top_module (
    input [2:0] in,
    output [1:0] out
);
    // Combinational logic
    always @* begin
        out[1] = in[2] ^ in[1] ^ in[0];
        out[0] = in[2] & in[1] | in[2] & in[0] | in[1] & in[0];
    end
endmodule
