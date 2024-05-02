module top_module( 
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different );

    reg [99:0] out_both;
    reg [99:1] out_any;
    reg [99:0] out_different;

    always @(posedge clk) begin
        out_both <= (in & in[1:0]);
        out_any <= (in | in[1:0]);
        out_different <= (in ^ in[1:0]);
    end

endmodule