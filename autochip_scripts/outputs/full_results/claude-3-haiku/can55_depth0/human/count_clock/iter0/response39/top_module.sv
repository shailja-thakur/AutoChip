module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

// Initialize the clock to 12:00 AM
initial begin
    hh = 8'h12;
    mm = 8'h00;
    ss = 8'h00;
    pm = 1'b0;
end

// Increment the clock on each enable signal
always @(posedge clk) begin
    if (reset) begin
        hh = 8'h12;
        mm = 8'h00;
        ss = 8'h00;
        pm = 1'b0;
    end
    else if (ena) begin
        // Increment seconds
        ss = (ss == 8'h59) ? 8'h00 : ss + 8'h01;
        
        // Increment minutes
        if (ss == 8'h00) begin
            mm = (mm == 8'h59) ? 8'h00 : mm + 8'h01;
            
            // Increment hours and toggle AM/PM
            if (mm == 8'h00) begin
                hh = (hh == 8'h12) ? 8'h01 : (hh == 8'h11) ? 8'h12 : hh + 8'h01;
                pm = (hh == 8'h12) ? ~pm : pm;
            end
        end
    end
end

endmodule
