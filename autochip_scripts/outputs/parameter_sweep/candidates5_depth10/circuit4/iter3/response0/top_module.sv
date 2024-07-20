module top_module (
    input a, 
    input b, 
    input c, 
    input d,
    output reg q
);

    always @(*) begin
        q = (!a && d) || (c && !d) || (b && c && d);
    end

    initial begin
        q = 0;
        
        // Simulate the testbench waveform
        #20 a = 0; b = 0; c = 0; d = 0;
        #20 a = 0; b = 0; c = 0; d = 0;
        #20 a = 0; b = 0; c = 0; d = 0;
        #20 a = 0; b = 0; c = 0; d = 0;
        #20 a = 0; b = 0; c = 0; d = 1;
        #20 a = 0; b = 0; c = 1; d = 0;
        #20 a = 0; b = 0; c = 1; d = 1;
        #20 a = 0; b = 1; c = 0; d = 0;
        #20 a = 0; b = 1; c = 0; d = 1;
        #20 a = 0; b = 1; c = 1; d = 0;
        #20 a = 0; b = 1; c = 1; d = 1;
        #20 a = 1; b = 0; c = 0; d = 0;
        #20 a = 1; b = 0; c = 0; d = 1;
        #20 a = 1; b = 0; c = 1; d = 0;
        #20 a = 1; b = 0; c = 1; d = 1;
        #20 a = 1; b = 1; c = 0; d = 0;
        #20 a = 1; b = 1; c = 0; d = 1;
        #20 a = 1; b = 1; c = 1; d = 0;
        #20 a = 1; b = 1; c = 1; d = 1;
        
        // Stop simulation
        $finish;
    end

endmodule
