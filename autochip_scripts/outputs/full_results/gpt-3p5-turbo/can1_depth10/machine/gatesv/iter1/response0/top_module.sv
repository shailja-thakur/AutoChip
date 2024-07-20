module top_module (
    input [3:0] in,
    output [2:0] out_both,
    output [3:0] out_any,
    output reg [3:0] out_different
);

    assign out_both = in[2:0] & in[3:1];
    assign out_any = {in[2:0], 1'b0};
    
    always @(*) begin
        out_different = in ^ {in[3:1], 1'b0};
    end

endmodule
