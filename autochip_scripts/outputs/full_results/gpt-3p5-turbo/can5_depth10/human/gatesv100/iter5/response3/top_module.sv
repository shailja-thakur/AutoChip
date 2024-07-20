module top_module (
    input [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);

    assign out_both = in[98:0] & in[99:1];
    
    assign out_any = {in[99], in[98:1]};
    
    assign out_different = {in[99]} ^ in[98:0];

    initial begin
        $dumpfile("wave.vcd");
        $dumpvars(0, top_module);
        #10;
        $finish;
    end

endmodule
