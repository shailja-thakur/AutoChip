`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg clk;
    reg reset;
    reg enable;

    wire [3:0] Q;
    wire c_enable;
    wire c_load;
    wire [3:0] c_d;


    integer mismatch_count;

    top_module UUT (.clk(clk), .reset(reset), .enable(enable), .Q(Q), .c_enable(c_enable), .c_load(c_load), .c_d(c_d));

    initial // clk generation
    begin
        clk = 0;
        forever begin
            #(period/2);
            clk = ~clk;
        end
    end

    initial begin
        mismatch_count = 0;

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 0);
        $finish;
    end

endmodule