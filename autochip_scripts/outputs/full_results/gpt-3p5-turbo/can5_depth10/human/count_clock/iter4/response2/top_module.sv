module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [3:0] hh_tens,
    output reg [3:0] hh_ones,
    output reg [3:0] mm_tens,
    output reg [3:0] mm_ones,
    output reg [3:0] ss_tens,
    output reg [3:0] ss_ones);

    reg [6:0] count;
    reg [6:0] ss_count;
    reg [3:0] hh_count;
    reg [3:0] mm_count;

    always @(posedge clk) begin
        if (reset) begin
            hh_count <= 4'b1100; // 12
            mm_count <= 4'b0000; // 00
            ss_count <= 4'b0000; // 00
            pm <= 1'b0; // AM
        end else if (ena) begin
            if (count == 15) begin
                count <= 0;
                ss_tens <= ss_count[3:2];
                ss_ones <= ss_count[1:0];
                ss_count <= ss_count + 1;
                if (ss_count == 10) begin
                    ss_count <= 0;
                    mm_tens <= mm_count[3:2];
                    mm_ones <= mm_count[1:0];
                    mm_count <= mm_count + 1;
                    if (mm_count == 10) begin
                        mm_count <= 0;
                        hh_tens <= hh_count[3:2];
                        hh_ones <= hh_count[1:0];
                        hh_count <= hh_count + 1;
                        if (hh_count == 10) begin
                            hh_count <= 0;
                            if (pm == 1'b0) // AM
                                pm <= 1'b1; // PM
                            else
                                pm <= 1'b0; // AM
                        end
                    end
                end
            end else begin
                count <= count + 1;
            end
        end
    end

endmodule
