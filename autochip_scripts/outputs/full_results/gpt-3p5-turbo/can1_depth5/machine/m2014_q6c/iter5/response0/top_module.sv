module top_module (
    input [6:1] y,
    input w,
    output reg Y2,
    output reg Y4
);

    always @ (*)
    begin
        Y2 = y[1] & (~w);
        Y4 = (y[2] & y[3] & y[5] & y[6]) & w;
    end

    initial
    begin
        $dumpfile("wave.vcd");
        $dumpvars(0, top_module);
        
        Y2 = 0;
        Y4 = 0;
        #10;
        
        // Generate random inputs
        // You can update this section based on your test requirements
        
        integer i;
        for (i = 0; i < 600; i = i + 1)
        begin
            // Generate random inputs for y and w
            // You can update this section based on your test requirements
            
            y = $random;
            w = $random;
            
            #10;
        end
        
        $finish;
    end

endmodule
