module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    // Convert a BCD-encoded value to binary value
    function [5:0] bcd_to_binary;
        input [7:0] bcd;
        bcd_to_binary = (bcd[7:4] * 10) + bcd[3:0];
    endfunction
    
    // Convert a binary value to BCD-encoded value
    function [7:0] binary_to_bcd;
        input [5:0] binary;
        binary_to_bcd = ((binary / 10) << 4) | (binary % 10);
    endfunction
    
    always @(posedge clk) begin
        if (reset) begin
            ss <= 8'h00;
            mm <= 8'h00;
            hh <= 8'h12;
            pm <= 0;
        end else if (ena) begin
            // Increment seconds
            if (bcd_to_binary(ss) < 59) begin
                ss <= binary_to_bcd(bcd_to_binary(ss) + 1);
            end else begin
                // Reset seconds to 00
                ss <= 8'h00;
                // Increment minutes
                if (bcd_to_binary(mm) < 59) begin
                    mm <= binary_to_bcd(bcd_to_binary(mm) + 1);
                end else begin
                    // Reset minutes to 00
                    mm <= 8'h00;
                    // Increment hours
                    if (bcd_to_binary(hh) < 12) begin
                        if (hh == 8'h11) begin
                            // If hour was 11, switch AM/PM
                            pm <= ~pm;
                        end
                        hh <= binary_to_bcd(bcd_to_binary(hh) + 1);
                    end else begin
                        // Reset hours to 01
                        hh <= 8'h01;
                    end
                    
                    // If it was 12, switch AM/PM as well
                    if (hh == 8'h12) begin
                        pm <= ~pm;
                    end

                    // if hours Ctrl:
                    if(hh==8'h12 && mm==8'h00 && ss==8'h00)
					begin
						if(pm ==1)
							pm<=0;
						else
							pm<=1;
					end
                end
            end
        end
    end
endmodule
