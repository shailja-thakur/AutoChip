module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss
);

// Define internal signals
reg [3:0] hour_tens;
reg [3:0] hour_ones;
reg [5:0] min_tens;
reg [3:0] min_ones;
reg [5:0] sec_tens;
reg [3:0] sec_ones;

always @(posedge clk) begin
    if (reset) begin
        pm <= 1'b0;
        hour_tens <= 4'b0001;
        hour_ones <= 4'b0010;
        min_tens <= 6'b0000;
        min_ones <= 4'b0000;
        sec_tens <= 6'b0000;
        sec_ones <= 4'b0000;
    end else if (ena) begin
        if (sec_ones == 4'b1001 && sec_tens == 6'b0101 &&
            min_ones == 4'b0101 && min_tens == 6'b0101 &&
            hour_ones == 4'b0001 && hour_tens == 4'b0001) begin
            // Reset to AM
            pm <= 1'b0;
            hour_tens <= 4'b0001;
            hour_ones <= 4'b0010;
            min_tens <= 6'b0000;
            min_ones <= 4'b0000;
            sec_tens <= 6'b0000;
            sec_ones <= 4'b0000;
        end else begin
            sec_ones <= sec_ones + 1;
            if (sec_ones == 4'b1010) begin
                sec_ones <= 4'b0000;
                sec_tens <= sec_tens + 1;
                if (sec_tens == 6'b0110) begin
                    sec_tens <= 6'b0000;
                    min_ones <= min_ones + 1;
                    if (min_ones == 4'b1010) begin
                        min_ones <= 4'b0000;
                        min_tens <= min_tens + 1;
                        if (min_tens == 6'b0110) begin
                            min_tens <= 6'b0000;
                            hour_ones <= hour_ones + 1;
                            if (hour_ones == 4'b1010) begin
                                hour_ones <= 4'b0000;
                                hour_tens <= hour_tens + 1;
                                if (hour_tens == 4'b0001 && hour_ones == 4'b0010) begin
                                    // Toggle PM indicator
                                    pm <= ~pm;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end

// Assign output signals
assign hh = {hour_tens, hour_ones};
assign mm = {min_tens, min_ones};
assign ss = {sec_tens, sec_ones};

endmodule
