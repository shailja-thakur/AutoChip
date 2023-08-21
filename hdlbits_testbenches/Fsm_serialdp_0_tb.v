`timescale 1 ns/10 ps  // time-unit = 1 ns, precision = 10 ps

module top_module_tb;

    // duration for each bit = 20 * timescale = 20 * 1 ns  = 20ns
    localparam period = 20;

    reg clk;
    reg in;
    reg reset;

    wire [7:0] out_byte;
    wire done;


    integer mismatch_count;

    top_module UUT (.clk(clk), .in(in), .reset(reset), .out_byte(out_byte), .done(done));

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

        // Tick 0: Inputs = 1'b1, 1'b0, 1'b0, Generated = out_byte, done, Reference = 1'b0, 1'b1
        in = 1'b0; reset = 1'b0; // Set input values
        #period;
        if (!(out_byte === 1'b0 && done === 1'b1)) begin
            $display("Mismatch at index 0: Inputs = [%b, %b, %b], Generated = [%b, %b], Reference = [%b, %b]", 1'b1, 1'b0, 1'b0, out_byte, done, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 0 passed!");
        end

        // Tick 1: Inputs = 1'b0, 1'b0, 1'b0, Generated = out_byte, done, Reference = 1'b0, 1'b1
        in = 1'b0; reset = 1'b0; // Set input values
        #period;
        if (!(out_byte === 1'b0 && done === 1'b1)) begin
            $display("Mismatch at index 1: Inputs = [%b, %b, %b], Generated = [%b, %b], Reference = [%b, %b]", 1'b0, 1'b0, 1'b0, out_byte, done, 1'b0, 1'b1);
            mismatch_count = mismatch_count + 1;
            $finish;
        end

        else begin
            $display("Test 1 passed!");
        end

        if (mismatch_count == 0)
            $display("All tests passed!");
        else
            $display("%0d mismatches out of %0d total tests.", mismatch_count, 2);
        $finish;
    end

endmodule