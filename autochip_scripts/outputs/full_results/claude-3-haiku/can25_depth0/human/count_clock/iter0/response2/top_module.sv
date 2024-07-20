module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

// Define constants for BCD digits
parameter ZERO = 8'b00110000;
parameter ONE = 8'b00110001;
parameter TWO = 8'b00110010;
parameter THREE = 8'b00110011;
parameter FOUR = 8'b00110100;
parameter FIVE = 8'b00110101;
parameter SIX = 8'b00110110;
parameter SEVEN = 8'b00110111;
parameter EIGHT = 8'b00111000;
parameter NINE = 8'b00111001;

always @(posedge clk) begin
    if (reset) begin
        // Reset the clock to 12:00 AM
        hh <= TWO | ONE;
        mm <= ZERO | ZERO;
        ss <= ZERO | ZERO;
        pm <= 0;
    end
    else if (ena) begin
        // Increment the clock
        if (ss == FIVE | NINE) begin
            // Seconds overflow, increment minutes
            if (mm == FIVE | NINE) begin
                // Minutes overflow, increment hours
                if (hh == ONE | TWO) begin
                    // Hours overflow, toggle AM/PM
                    pm <= ~pm;
                    if (hh == TWO) begin
                        hh <= ONE | ZERO;
                    end
                    else begin
                        hh <= ONE | ZERO;
                    end
                end
                else begin
                    hh <= hh + 1;
                end
                mm <= ZERO | ZERO;
            end
            else begin
                mm <= mm + 1;
            end
            ss <= ZERO | ZERO;
        end
        else begin
            ss <= ss + 1;
        end
    end
end

endmodule
