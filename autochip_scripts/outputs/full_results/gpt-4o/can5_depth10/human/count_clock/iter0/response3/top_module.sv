module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    reg [3:0] ss_units, ss_tens, mm_units, mm_tens, hh_units, hh_tens;

    always @(posedge clk) begin
        if (reset) begin
            // Active high reset
            ss_units <= 4'd0;
            ss_tens <= 4'd0;
            mm_units <= 4'd0;
            mm_tens <= 4'd0;
            hh_units <= 4'd2; // Start at "12:00"
            hh_tens <= 4'd1; // Start at "12:00"
            pm <= 1'b0; // Start at AM
        end
        else if (ena) begin
            // Seconds
            if (ss_units == 4'd9) begin
                ss_units <= 4'd0;
                if (ss_tens == 4'd5) begin
                    ss_tens <= 4'd0;
                    
                    // Minutes
                    if (mm_units == 4'd9) begin
                        mm_units <= 4'd0;
                        if (mm_tens == 4'd5) begin
                            mm_tens <= 4'd0;
                            
                            // Hours
                            if ((hh_units == 4'd9) || (hh_units == 4'd2 && hh_tens == 4'd1)) begin
                                if (hh_tens == 4'd1) begin
                                    hh_tens <= 4'd0;
                                    hh_units <= 4'd1; 
                                end else if (hh_units == 4'd2 && hh_tens == 4'd0) begin
                                    hh_units <= 4'd0;
                                    if (pm) begin
                                        pm <= 1'b0;
                                    end else begin
                                        pm <= 1'b1;
                                    end
                                end else if (hh_units == 4'd9) begin
                                    hh_units <= hh_units + 4'd1;
                    
                                end else begin
                                    hh_units <= 4'd1;
                                end
                            end else begin
                                hh_units <= hh_units + 4'd1;
                            end
                        end else begin
                            mm_tens <= mm_tens + 4'd1;
                        end
                    end else begin
                        mm_units <= mm_units + 4'd1;
                    end
                end else begin
                    ss_tens <= ss_tens + 4'd1;
                end
            end else begin
                ss_units <= ss_units + 4'd1;
            end
        end

        // Update BCD outputs
        hh <= {hh_tens, hh_units};
        mm <= {mm_tens, mm_units};
        ss <= {ss_tens, ss_units};
    end
endmodule
