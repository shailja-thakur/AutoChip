module top_module (
    input [31:0] in,
    output [31:0] out
);

    reg [7:0] out_temp [3:0];
    integer i;

    always @(*) begin
        for (i = 0; i < 4; i = i + 1) begin
            out_temp[i] = in[i * 8 +: 8];
        end
        
        out = {out_temp[3], out_temp[2], out_temp[1], out_temp[0]};
    end

endmodule
