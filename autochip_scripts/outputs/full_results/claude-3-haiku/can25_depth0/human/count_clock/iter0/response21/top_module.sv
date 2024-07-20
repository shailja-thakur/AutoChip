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

    always @(posedge clk) begin
        if (reset) begin
            // Reset the clock to 12:00 AM
            hh = 8'h12;
            mm = 8'h00;
            ss = 8'h00;
            pm = 1'b0;
        end
        else if (ena) begin
            // Increment the clock
            ss = ss + 8'h01;
            if (ss == 8'h60) begin
                ss = 8'h00;
                mm = mm + 8'h01;
                if (mm == 8'h60) begin
                    mm = 8'h00;
                    hh = hh + 8'h01;
                    if (hh == 8'h13) begin
                        hh = 8'h01;
                        pm = ~pm;
                    end
                end
            end
        end
    end

endmodule
