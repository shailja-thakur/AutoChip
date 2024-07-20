module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    reg [21:0] count;
    reg [3:0] hour_tens;
    reg [3:0] hour_ones;
    reg [5:0] min_tens;
    reg [3:0] min_ones;
    reg [5:0] sec_tens;
    reg [3:0] sec_ones;

    always @(posedge clk) begin
        if (reset) begin
            count <= 0;
            hour_tens <= 0;
            hour_ones <= 0;
            min_tens <= 0;
            min_ones <= 0;
            sec_tens <= 0;
            sec_ones <= 0;
            pm <= 0;
        end else if (ena) begin
            count <= count + 1;

            if (count == 999_999) begin
                sec_ones <= sec_ones + 1;

                if (sec_ones == 10) begin
                    sec_ones <= 0;
                    sec_tens <= sec_tens + 1;

                    if (sec_tens == 6) begin
                        sec_tens <= 0;
                        min_ones <= min_ones + 1;

                        if (min_ones == 10) begin
                            min_ones <= 0;
                            min_tens <= min_tens + 1;

                            if (min_tens == 6) begin
                                min_tens <= 0;
                                hour_ones <= hour_ones + 1;

                                if (hour_ones == 10 && hour_tens != 1) begin
                                    hour_ones <= 0;
                                    hour_tens <= hour_tens + 1;
                                end

                                if (hour_tens == 1 && hour_ones == 3) begin
                                    hour_tens <= 0;

                                    if (pm) begin
                                        pm <= 0;
                                    end else begin
                                        pm <= 1;
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b00000000;
            mm <= 8'b00000000;
            ss <= 8'b00000000;
        end else if (ena) begin
            if (count == 0) begin
                hh <= {4'b0000, hour_tens, hour_ones};
                mm <= {4'b0000, min_tens, min_ones};
                ss <= {4'b0000, sec_tens, sec_ones};
            end
        end
    end

endmodule
module top_module_tb();

  reg clk, reset, ena;
  wire  [7:0]  hh, mm, ss;
  wire pm;

  top_module dut (
    .clk(clk),
    .reset(reset),
    .ena(ena),
    .hh(hh),
    .mm(mm),
    .ss(ss),
    .pm(pm)
  );

  initial begin
    clk = 0;
    reset = 1;
    ena = 0;

    // Reset
    #5 reset = 0;

    // Enable
    #10 ena = 1;

    // Clock edge
    #5  ena = 0;
    #5 ena = 1;

    // Wait for 12 hours
    repeat(432_000) begin
      #1 clk = ~clk;
    end

    // Stop Simulation
    $finish;
  end

endmodule
