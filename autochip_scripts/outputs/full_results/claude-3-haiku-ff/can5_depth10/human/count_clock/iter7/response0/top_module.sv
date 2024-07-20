module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output [3:0] hh,
    output [3:0] mm,
    output [3:0] ss
);

reg [3:0] hh_reg, mm_reg, ss_reg;

always @(posedge clk) begin
    if (reset) begin
        hh_reg <= 4'h1;
        mm_reg <= 4'h0;
        ss_reg <= 4'h0;
        pm <= 0;
    end
    else if (ena) begin
        // Increment seconds
        if (ss_reg == 4'h9) begin
            ss_reg <= 4'h0;
            // Increment minutes
            if (mm_reg == 4'h5) begin
                mm_reg <= 4'h0;
                // Increment hours
                if (hh_reg == 4'h2) begin
                    hh_reg <= 4'h1;
                    pm <= ~pm;
                end
                else begin
                    hh_reg <= hh_reg + 4'h1;
                end
            end
            else begin
                mm_reg <= mm_reg + 4'h1;
            end
        end
        else begin
            ss_reg <= ss_reg + 4'h1;
        end
    end
end

assign hh = hh_reg;
assign mm = mm_reg;
assign ss = ss_reg;

endmodule
