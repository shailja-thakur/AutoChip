module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    // Internal signals for digit increments
    reg [3:0] sec_ones;
    reg [3:0] sec_tens;
    reg [3:0] min_ones;
    reg [3:0] min_tens;
    reg [3:0] hour_ones;
    reg [3:0] hour_tens;

    // Initialize everything in an initial block
    initial begin
        pm = 0;
        hh = 8'h12;
        mm = 8'h00;
        ss = 8'h00;
        sec_ones = 4'b0000;
        sec_tens = 4'b0000;
        min_ones = 4'b0000;
        min_tens = 4'b0000;
        hour_ones = 4'b0010; // 12 in BCD
        hour_tens = 4'b0001; // 12 in BCD
    end
    
    // Updating seconds, minutes, hours, and PM/AM status
    always @(posedge clk) begin
        if (reset) begin
            // Reset to 12:00:00 AM
            pm <= 0;
            hh <= 8'h12;
            mm <= 8'h00;
            ss <= 8'h00;
            sec_ones <= 4'b0000;
            sec_tens <= 4'b0000;
            min_ones <= 4'b0000;
            min_tens <= 4'b0000;
            hour_ones <= 4'b0010; // 12 in BCD
            hour_tens <= 4'b0001; // 12 in BCD
        end else if (ena) begin
            // Increment seconds
            if (ss == 8'h59) begin
                ss <= 8'h00;
                
                // Increment minutes
                if (mm == 8'h59) begin
                    mm <= 8'h00;

                    // Increment hours
                    if ((hh == 8'h12 && !pm) || (hh == 8'h11 && pm)) begin
                        hh <= 8'h01;
                        if (hh == 8'h12 && pm) pm <= 0; else pm <= !pm;
                    end else if(hh == 8'h12 && pm) begin
                        hh <= 8'h01;
                    end else begin
                        if (hour_ones == 4'b1001) begin // 09 condition
                            hour_ones <= 4'b0000;
                            hour_tens <= hour_tens + 1;
                        end else if (hour_ones == 4'b0010 && hour_tens == 4'b0001) begin // 12 condition
                            hour_ones <= 4'b0001; // Wrap around to 01
                            hour_tens <= 4'b0000;
                        end else begin
                            hour_ones <= hour_ones + 1;
                        end
                    end
                end else begin
                    if (min_ones == 4'b1001) begin // 59 condition
                        min_ones <= 4'b0000;
                        min_tens <= min_tens + 1;
                    end else begin
                        min_ones <= min_ones + 1;
                    end
                end
            end else begin
                if (sec_ones == 4'b1001) begin // 09 condition
                    sec_ones <= 4'b0000;
                    sec_tens <= sec_tens + 1;
                end else begin
                    sec_ones <= sec_ones + 1;
                end
            end

            // Update the main BCD outputs
            ss <= {sec_tens, sec_ones};
            mm <= {min_tens, min_ones};
            hh <= {hour_tens, hour_ones};
        end
    end
endmodule
