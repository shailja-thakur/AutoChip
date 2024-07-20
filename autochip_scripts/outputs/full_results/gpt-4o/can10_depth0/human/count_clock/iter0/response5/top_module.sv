module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

    always @(posedge clk) begin
        if (reset) begin
            ss <= 8'b00000000; // "00" in BCD
            mm <= 8'b00000000; // "00" in BCD
            hh <= 8'b00010010; // "12" in BCD
            pm <= 0;           // AM
        end
        else if (ena) begin
            // Seconds counter
            if (ss[3:0] == 9) begin
                ss[3:0] <= 0;
                if (ss[7:4] == 5) begin
                    ss[7:4] <= 0;

                    // Minutes counter
                    if (mm[3:0] == 9) begin
                        mm[3:0] <= 0;
                        if (mm[7:4] == 5) begin
                            mm[7:4] <= 0;

                            // Hours counter
                            if (hh[3:0] == 9) begin
                                hh[3:0] <= 0;
                                if (hh[7:4] == 1) begin
                                    hh[7:4] <= 0;
                                    if (hh[3:0] == 2) begin
                                        hh[3:0] <= 1; // Wrap around from "12" to "01"
                                        pm <= ~pm;  // Toggle AM/PM
                                    end
                                end
                                else begin
                                    hh[7:4] <= hh[7:4] + 1;
                                end
                            end
                            else begin
                                hh[3:0] <= hh[3:0] + 1;
                                if ((hh == 8'b00010010 && !pm) || (hh == 8'b00100010)) begin
                                    // Special case for "11" to "12" transition
                                    hh <= 8'b00010001;  // Set to "01"
                                    pm <= ~pm;          // Toggle AM/PM
                                end
                            end
                        end
                        else begin
                            mm[7:4] <= mm[7:4] + 1;
                        end
                    end
                    else begin
                        mm[3:0] <= mm[3:0] + 1;
                    end
                end
                else begin
                    ss[7:4] <= ss[7:4] + 1;
                end
            end
            else begin
                ss[3:0] <= ss[3:0] + 1;
            end
        end
    end

endmodule
