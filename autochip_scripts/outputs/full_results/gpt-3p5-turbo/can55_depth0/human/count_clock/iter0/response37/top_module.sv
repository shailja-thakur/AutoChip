module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    reg [7:0] hh_count;
    reg [7:0] mm_count;
    reg [7:0] ss_count;

    always @(posedge clk) begin
        if (reset) begin
            hh_count <= 8'b00000000;
            mm_count <= 8'b00000000;
            ss_count <= 8'b00000000;
            hh <= 8'b00010010; // 12 in BCD form
            mm <= 8'b00000000;
            ss <= 8'b00000000;
            pm <= 1'b0;
        end else if (ena) begin
            ss_count <= ss_count + 8'b00000001;
            if (ss_count == 8'b01100010) begin // 60 in BCD form
                ss_count <= 8'b00000000;
                mm_count <= mm_count + 8'b00000001;
                if (mm_count == 8'b01100010) begin // 60 in BCD form
                    mm_count <= 8'b00000000;
                    hh_count <= hh_count + 8'b00000001;
                    if (hh_count == 8'b00011001) begin // 24 in BCD form
                        hh_count <= 8'b00000000;
                        pm <= ~pm;
                    end
                    hh <= hh_count;
                end
                mm <= mm_count;
            end
            ss <= ss_count;
        end
    end

endmodule
