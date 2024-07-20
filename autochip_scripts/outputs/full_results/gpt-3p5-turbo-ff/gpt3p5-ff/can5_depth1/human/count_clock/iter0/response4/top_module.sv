module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);

    reg [7:0] sec_count;
    reg [7:0] min_count;
    reg [7:0] hour_count;

    always @(posedge clk) begin
        if (reset) begin
            sec_count <= 8'd0;
            min_count <= 8'd0;
            hour_count <= 8'd0;
            pm <= 1'b0;
        end else if (ena) begin
            sec_count <= sec_count + 1;
            if (sec_count == 8'd59) begin
                sec_count <= 8'd0;
                min_count <= min_count + 1;
                if (min_count == 8'd59) begin
                    min_count <= 8'd0;
                    hour_count <= hour_count + 1;
                    if (hour_count == 8'd11) begin
                        hour_count <= 8'd0;
                        pm <= ~pm;
                    end
                end
            end
        end
    end

    always @(posedge clk) begin
        if (reset) begin
            hh <= 8'd0;
            mm <= 8'd0;
            ss <= 8'd0;
        end else if (ena) begin
            if (sec_count < 8'd10)
                ss <= {1'b0, sec_count};
            else
                ss <= sec_count;
            
            if (min_count < 8'd10)
                mm <= {1'b0, min_count};
            else
                mm <= min_count;
            
            if (hour_count == 8'd0 || hour_count == 8'd10 || hour_count == 8'd11)
                hh <= {1'b0, 4'b0001};
            else if (hour_count < 8'd10)
                hh <= {1'b0, hour_count};
            else
                hh <= hour_count;
        end
    end

endmodule
