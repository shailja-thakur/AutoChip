module top_module (
    input wire a,
    input wire b,
    input wire c,
    input wire d,
    output reg q
);

    always @(*)
    begin
        case ({c, d})
            2'b00: q = 1'b0;
            2'b01: q = b;
            2'b10: q = a;
            2'b11: q = 1'b1;
        endcase
    end

    initial
    begin
        $dumpfile("wave.vcd");
        $dumpvars(0, top_module);
        
        // Test input values
        #20 a = 0; b = 0; c = 0; d = 0;
        #10 a = 0; b = 0; c = 0; d = 0;
        #10 a = 0; b = 0; c = 0; d = 0;
        #10 a = 0; b = 0; c = 0; d = 0;
        #5  a = 0; b = 0; c = 0; d = 1;
        #5  a = 0; b = 0; c = 1; d = 0;
        #5  a = 0; b = 0; c = 1; d = 1;
        #5  a = 0; b = 1; c = 0; d = 0;
        #5  a = 0; b = 1; c = 0; d = 1;
        #5  a = 0; b = 1; c = 1; d = 0;
        #5  a = 0; b = 1; c = 1; d = 1;
        #5  a = 1; b = 0; c = 0; d = 0;
        #5  a = 1; b = 0; c = 0; d = 1;
        #5  a = 1; b = 0; c = 1; d = 0;
        #5  a = 1; b = 0; c = 1; d = 1;
        #5  a = 1; b = 1; c = 0; d = 0;
        #5  a = 1; b = 1; c = 0; d = 1;
        #5  a = 1; b = 1; c = 1; d = 0;
        #5  a = 1; b = 1; c = 1; d = 1;

        $finish;
    end

endmodule
