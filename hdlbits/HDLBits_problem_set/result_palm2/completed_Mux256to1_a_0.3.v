module top_module( 
    input [255:0] in,
    input [7:0] sel,
    output out );

    always @(sel or in) begin
        out = in[sel];
    end

endmodule