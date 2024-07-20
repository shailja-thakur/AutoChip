module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output [3:0] out
);

    reg [3:0] out_reg;

    always @(sel) begin
        integer start_index;
        start_index = sel * 4;
        
        out_reg = in[start_index +: 4];
    end

    assign out = out_reg;

endmodule
