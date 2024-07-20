module top_module (
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

    // initialize all outputs to default values
    initial begin
        hh = 8'h12; // "12" in BCD
        mm = 8'h00; // "00" in BCD
        ss = 8'h00; // "00" in BCD
        pm = 0;     // AM by default
    end

    always @(posedge clk) begin
        if (reset) begin
            // reset to "12:00:00 AM"
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
            pm <= 0;
        end else if (ena) begin
            if (ss == 8'h59) begin
                ss <= 8'h00; // reset seconds to 00

                if (mm == 8'h59) begin
                    mm <= 8'h00; // reset minutes to 00

                    if ((hh == 8'h12) && !pm) begin
                        // transition from 12:xx:xx AM to 01:xx:xx PM
                        hh <= 8'h01;
                        pm <= 1;
                    end else if ((hh == 8'h12) && pm) begin
                        // transition from 12:xx:xx PM to 01:xx:xx AM
                        hh <= 8'h01;
                        pm <= 0;
                    end else if (hh == 8'h11) begin
                        // transition from 11:xx:xx to 12:xx:xx without toggling AM/PM
                        hh <= 8'h12;
                    end else begin
                        // normal increment (if the hour is 01 to 10)
                        hh <= hh + 1;
                    end
                end else begin
                    mm <= mm + 1; // normal increment of minutes
                end
            end else begin
                ss <= ss + 1; // normal increment of seconds
            end
        end
    end
endmodule
