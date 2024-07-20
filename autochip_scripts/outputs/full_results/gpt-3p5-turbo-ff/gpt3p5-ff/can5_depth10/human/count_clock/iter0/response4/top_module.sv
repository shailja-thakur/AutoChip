module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    wire clk_en;

    // Counter for seconds
    reg [7:0] sec_count = 8'h00;
    always @(posedge clk) begin
        if (reset)
            sec_count <= 8'h00;
        else if (ena)
            sec_count <= sec_count + 1;
    end

    // Counter for minutes
    reg [7:0] min_count = 8'h00;
    always @(posedge clk_en) begin
        if (reset)
            min_count <= 8'h00;
        else if (sec_count == 8'h59)
            min_count <= min_count + 1;
    end

    // Counter for hours
    reg [7:0] hour_count = 8'h12;
    always @(posedge clk_en) begin
        if (reset)
            hour_count <= 8'h12;
        else if (min_count == 8'h59 && sec_count == 8'h59) begin
            if (hour_count == 8'h11)
                hour_count <= 8'h00;
            else if (hour_count == 8'h12)
                hour_count <= 8'h01;
            else
                hour_count <= hour_count + 1;
        end
    end

    // Convert the binary-coded decimal (BCD) counters to regular binary format
    always @(hour_count, min_count, sec_count) begin
        hh = (hour_count / 10) << 4 | (hour_count % 10);
        mm = (min_count / 10) << 4 | (min_count % 10);
        ss = (sec_count / 10) << 4 | (sec_count % 10);
    end

    // Update the am/pm indicator
    always @(hour_count) begin
        if (hour_count >= 8'h12)
            pm = 1'b1;
        else
            pm = 1'b0;
    end

endmodule
