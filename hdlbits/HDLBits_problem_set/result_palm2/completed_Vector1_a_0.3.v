module top_module( 
    input wire [15:0] in,
    output wire [7:0] out_hi,
    output wire [7:0] out_lo );

    always @(in) begin
        out_hi <= in[15:8];
        out_lo <= in[7:0];
    end

endmodule