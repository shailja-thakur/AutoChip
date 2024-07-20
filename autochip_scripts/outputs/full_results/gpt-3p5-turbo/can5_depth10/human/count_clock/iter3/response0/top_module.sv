module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    reg [3:0] bcd_hh;
    reg [3:0] bcd_mm;
    reg [3:0] bcd_ss;
  
    reg [1:0] tens_hh;
    reg [3:0] ones_hh;
    reg [3:0] tens_mm;
    reg [3:0] ones_mm;
    reg [3:0] tens_ss;
    reg [3:0] ones_ss;
  
    always @(posedge clk) begin
        if (reset) begin
            bcd_hh <= 4'b0000; // initialize hours
            bcd_mm <= 4'b0000; // initialize minutes
            bcd_ss <= 4'b0000; // initialize seconds
            pm <= 1'b0; // AM
        end else if (ena) begin
            bcd_ss <= bcd_ss + 1;
            if (bcd_ss >= 4'b1001) begin
                bcd_ss <= 4'b0000;
                bcd_mm <= bcd_mm + 1;
                if (bcd_mm >= 4'b0110) begin
                    bcd_mm <= 4'b0000;
                    bcd_hh <= bcd_hh + 1;
                    if (bcd_hh >= 4'b1010) begin
                        bcd_hh <= 4'b0000;
                        pm <= ~pm; // toggle AM/PM indicator
                    end
                end
            end
        end
    end
  
    always @(bcd_hh) begin
        case (bcd_hh)
            4'b0000: begin
                tens_hh <= 2'b00;
                ones_hh <= 4'b0000;
            end
            4'b0001: begin
                tens_hh <= 2'b00;
                ones_hh <= 4'b0001;
            end
            4'b0010: begin
                tens_hh <= 2'b00;
                ones_hh <= 4'b0010;
            end
            4'b0011: begin
                tens_hh <= 2'b00;
                ones_hh <= 4'b0011;
            end
            4'b0100: begin
                tens_hh <= 2'b00;
                ones_hh <= 4'b0100;
            end
            4'b0101: begin
                tens_hh <= 2'b00;
                ones_hh <= 4'b0101;
            end
            4'b0110: begin
                tens_hh <= 2'b00;
                ones_hh <= 4'b0110;
            end
            4'b0111: begin
                tens_hh <= 2'b00;
                ones_hh <= 4'b0111;
            end
            4'b1000: begin
                tens_hh <= 2'b00;
                ones_hh <= 4'b1000;
            end
            4'b1001: begin
                tens_hh <= 2'b01;
                ones_hh <= 4'b0001;
            end
            4'b1010: begin
                tens_hh <= 2'b01;
                ones_hh <= 4'b0010;
            end
            default: begin
                tens_hh <= 2'b00;
                ones_hh <= 4'b0000;
            end
        endcase
    end
  
    always @(bcd_mm) begin
        case (bcd_mm)
            4'b0000: begin
                tens_mm <= 4'b0000;
                ones_mm <= 4'b0000;
            end
            4'b0001: begin
                tens_mm <= 4'b0000;
                ones_mm <= 4'b0001;
            end
            4'b0010: begin
                tens_mm <= 4'b0000;
                ones_mm <= 4'b0010;
            end
            4'b0011: begin
                tens_mm <= 4'b0000;
                ones_mm <= 4'b0011;
            end
            4'b0100: begin
                tens_mm <= 4'b0000;
                ones_mm <= 4'b0100;
            end
            4'b0101: begin
                tens_mm <= 4'b0000;
                ones_mm <= 4'b0101;
            end
            4'b0110: begin
                tens_mm <= 4'b0000;
                ones_mm <= 4'b0110;
            end
            4'b0111: begin
                tens_mm <= 4'b0000;
                ones_mm <= 4'b0111;
            end
            4'b1000: begin
                tens_mm <= 4'b0000;
                ones_mm <= 4'b1000;
            end
            4'b1001: begin
                tens_mm <= 4'b0001;
                ones_mm <= 4'b0001;
            end
            4'b1010: begin
                tens_mm <= 4'b0001;
                ones_mm <= 4'b0010;
            end
            4'b1011: begin
                tens_mm <= 4'b0001;
                ones_mm <= 4'b0011;
            end
            4'b1100: begin
                tens_mm <= 4'b0001;
                ones_mm <= 4'b0100;
            end
            4'b1101: begin
                tens_mm <= 4'b0001;
                ones_mm <= 4'b0101;
            end
            4'b1110: begin
                tens_mm <= 4'b0001;
                ones_mm <= 4'b0110;
            end
            4'b1111: begin
                tens_mm <= 4'b0001;
                ones_mm <= 4'b0111;
            end
            default: begin
                tens_mm <= 4'b0000;
                ones_mm <= 4'b0000;
            end
        endcase
    end
  
    always @(bcd_ss) begin
        case (bcd_ss)
            4'b0000: begin
                tens_ss <= 4'b0000;
                ones_ss <= 4'b0000;
            end
            4'b0001: begin
                tens_ss <= 4'b0000;
                ones_ss <= 4'b0001;
            end
            4'b0010: begin
                tens_ss <= 4'b0000;
                ones_ss <= 4'b0010;
            end
            4'b0011: begin
                tens_ss <= 4'b0000;
                ones_ss <= 4'b0011;
            end
            4'b0100: begin
                tens_ss <= 4'b0000;
                ones_ss <= 4'b0100;
            end
            4'b0101: begin
                tens_ss <= 4'b0000;
                ones_ss <= 4'b0101;
            end
            4'b0110: begin
                tens_ss <= 4'b0000;
                ones_ss <= 4'b0110;
            end
            4'b0111: begin
                tens_ss <= 4'b0000;
                ones_ss <= 4'b0111;
            end
            4'b1000: begin
                tens_ss <= 4'b0000;
                ones_ss <= 4'b1000;
            end
            4'b1001: begin
                tens_ss <= 4'b0001;
                ones_ss <= 4'b0001;
            end
            4'b1010: begin
                tens_ss <= 4'b0001;
                ones_ss <= 4'b0010;
            end
            4'b1011: begin
                tens_ss <= 4'b0001;
                ones_ss <= 4'b0011;
            end
            4'b1100: begin
                tens_ss <= 4'b0001;
                ones_ss <= 4'b0100;
            end
            4'b1101: begin
                tens_ss <= 4'b0001;
                ones_ss <= 4'b0101;
            end
            4'b1110: begin
                tens_ss <= 4'b0001;
                ones_ss <= 4'b0110;
            end
            4'b1111: begin
                tens_ss <= 4'b0001;
                ones_ss <= 4'b0111;
            end
            default: begin
                tens_ss <= 4'b0000;
                ones_ss <= 4'b0000;
            end
        endcase
    end
  
    assign hh = {tens_hh, ones_hh};
    assign mm = {tens_mm, ones_mm};
    assign ss = {tens_ss, ones_ss};
       
endmodule
