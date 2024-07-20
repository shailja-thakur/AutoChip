module top_module (
    input [1023:0] in,
    input [7:0] sel,
    output reg [3:0] out
);

    always @(*) begin
        case (sel)
            8'd0: out = in[3:0];
            8'd1: out = in[7:4];
            8'd2: out = in[11:8];
            //...
            8'd255: out = in[1023:1020];
            default: out = 4'b0000;
        endcase
    end

endmodule
