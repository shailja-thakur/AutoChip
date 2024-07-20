module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [9:0] hh,
    output reg [9:0] mm,
    output reg [9:0] ss);

    reg [3:0] counter_hh_1;
    reg [3:0] counter_hh_0;
    reg [3:0] counter_mm_1;
    reg [3:0] counter_mm_0;
    reg [3:0] counter_ss_1;
    reg [3:0] counter_ss_0;
    
    always @(posedge clk) begin
        if (reset) begin
            counter_hh_1 <= 4'b0001;
            counter_hh_0 <= 4'b0010;
            counter_mm_1 <= 4'b0000;
            counter_mm_0 <= 4'b0000;
            counter_ss_1 <= 4'b0000;
            counter_ss_0 <= 4'b0000;
            pm <= 1'b0;
        end else begin
            if (ena) begin
                counter_ss_0 <= counter_ss_0 + 1;
                if (counter_ss_0 == 4'b1001) begin
                    counter_ss_0 <= 0;
                    counter_ss_1 <= counter_ss_1 + 1;
                    if (counter_ss_1 == 4'b1001) begin
                        counter_ss_1 <= 0;
                        counter_mm_0 <= counter_mm_0 + 1;
                        if (counter_mm_0 == 4'b1001) begin
                            counter_mm_0 <= 0;
                            counter_mm_1 <= counter_mm_1 + 1;
                            if (counter_mm_1 == 4'b0110) begin
                                counter_mm_1 <= 0;
                                counter_hh_0 <= counter_hh_0 + 1;
                                if (counter_hh_0[3:0] == 4'h0 || counter_hh_0[3:0] == 4'h1) begin
                                    if (counter_hh_1[3:0] == 4'h0) begin
                                        counter_hh_1 <= counter_hh_1 + 1;
                                        if (counter_hh_1[3:0] == 4'h1)
                                            counter_hh_1[3:0] = 4'h1;
                                        pm <= ~pm;
                                    end else if (counter_hh_0[3:0] == 4'h1) 
                                        counter_hh_0[3:0] = 4'h0;
                                end
                                if (counter_hh_0[3:0] == 4'h2) 
                                    counter_hh_0[3:0] = 4'h0;
                            end
                        end
                    end
                end
            end
        end
    end
    
    assign hh = {2'b0, counter_hh_1, 2'b0, counter_hh_0};
    assign mm = {2'b0, counter_mm_1, 2'b0, counter_mm_0};
    assign ss = {2'b0, counter_ss_1, 2'b0, counter_ss_0};
    
endmodule
