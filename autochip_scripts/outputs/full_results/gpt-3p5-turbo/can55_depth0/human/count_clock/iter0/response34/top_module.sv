module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

    reg [3:0] hh_tens;
    reg [3:0] hh_ones;
    reg [3:0] mm_tens;
    reg [3:0] mm_ones;
    reg [3:0] ss_tens;
    reg [3:0] ss_ones;
    
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            hh_tens <= 4'b0000;
            hh_ones <= 4'b0000;
            mm_tens <= 4'b0000;
            mm_ones <= 4'b0000;
            ss_tens <= 4'b0000;
            ss_ones <= 4'b0000;
            pm <= 1'b0;
        end else if (ena) begin
            if (ss_ones == 4'b1001) begin
                ss_ones <= 4'b0000;
                ss_tens <= ss_tens + 1;
                if (ss_tens == 4'b1010) begin
                    ss_tens <= 4'b0000;
                    mm_ones <= mm_ones + 1;
                    if (mm_ones == 4'b1010) begin
                        mm_ones <= 4'b0000;
                        mm_tens <= mm_tens + 1;
                        if (mm_tens == 4'b0110) begin
                            mm_tens <= 4'b0000;
                            if (hh_ones == 4'b1001) begin
                                hh_ones <= 4'b0000;
                                hh_tens <= hh_tens + 1;
                                if (hh_tens == 4'b0001) begin
                                    hh_tens <= 4'b0000;
                                    if (!pm) begin
                                        pm <= 1'b1;
                                    end else begin
                                        pm <= 1'b0;
                                    end
                                end
                            end else begin
                                hh_ones <= hh_ones + 1;
                            end
                        end
                    end
                end
            end else begin
                ss_ones <= ss_ones + 1;
            end
        end
    end
    
    assign hh = {hh_tens, hh_ones};
    assign mm = {mm_tens, mm_ones};
    assign ss = {ss_tens, ss_ones};

endmodule
