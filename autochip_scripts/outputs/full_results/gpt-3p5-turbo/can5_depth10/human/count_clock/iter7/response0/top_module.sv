module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [9:0] hh, // Update size to accommodate two-digit BCD representation
    output reg [9:0] mm, // Update size to accommodate two-digit BCD representation
    output reg [9:0] ss); // Update size to accommodate two-digit BCD representation

    always @(posedge clk) begin
        if (reset) begin
            hh <= 10'b0000010010; // 12
            mm <= 10'b0000000000; // 00
            ss <= 10'b0000000000; // 00
            pm <= 1'b0; // AM
        end else if (ena) begin
            if (ss >= 10'b0011100110) begin // Adjust condition to compare with two-digit BCD representation
                ss <= 10'b0000000000; // reset seconds
                mm <= mm + 10'b0000000001;
                if (mm >= 10'b0110110000) begin // Adjust condition to compare with two-digit BCD representation
                    mm <= 10'b0000000000; // reset minutes
                    hh <= hh + 10'b0000000001;
                    if (hh >= 10'b0001101010) begin // Adjust condition to compare with two-digit BCD representation
                        hh <= 10'b0000000001; // reset hours
                        pm <= ~pm; // toggle AM/PM indicator
                    end
                end
            end else begin
                ss <= ss + 10'b0000000001;
            end
        end
    end

endmodule
