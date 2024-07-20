module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    reg [3:0] hr_count;
    reg [5:0] min_count;
    reg [5:0] sec_count;
    
    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'b00000000;
            mm <= 8'b00000000;
            ss <= 8'b00000000;
            hr_count <= 4'b0000;
            min_count <= 6'b000000;
            sec_count <= 6'b000000;
            pm <= 0;
        end else if (ena) begin
            if (sec_count == 6'b101001 || sec_count == 6'b110010) begin // Check if it's the end of a minute
                if (min_count == 6'b110010) begin // Check if it's the end of an hour
                    if (hr_count == 4'b1010) begin // Check if it's the end of a day
                        hr_count <= 4'b0000;
                        pm <= !pm;
                    end else begin
                        hr_count <= hr_count + 1;
                    end
                    min_count <= 6'b000000;
                end else begin
                    min_count <= min_count + 1;
                end
                sec_count <= 6'b000000;
            end else begin
                sec_count <= sec_count + 1;
            end
            hh <= {pm, hr_count};
            mm <= min_count;
            ss <= sec_count;
        end
    end

endmodule
