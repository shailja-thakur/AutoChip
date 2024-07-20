module top_module(
    input clk,
    input reset,
    input ena,
    output reg pm,
    output reg [7:0] hh,
    output reg [7:0] mm,
    output reg [7:0] ss);
    
    // Counter for seconds
    reg [7:0] sec_count;
    
    // Counter for minutes
    reg [7:0] min_count;
    
    // Counter for hours
    reg [7:0] hour_count;
    
    // AM/PM indicator
    wire am;
    
    // BCD to 7-segment decoder
    reg [6:0] seg_decoder;
    
    // Connect BCD to 7-segment decoder
    seg_decoder = hh;
    
    // Calculate AM/PM indicator
    assign am = (hour_count >= 12);
    
    // Assign outputs
    assign pm = ~am;
    assign hh = seg_decoder;
    assign mm = min_count;
    assign ss = sec_count;
    
    // Counter for seconds
    always @(posedge clk) begin
        if (reset) begin
            sec_count <= 8'b0000_0000;
        end else if (ena) begin
            if (sec_count == 8'h59) begin
                sec_count <= 8'b0000_0000;
                min_count <= min_count + 1;
                
                if (min_count == 8'h59) begin
                    min_count <= 8'b0000_0000;
                    hour_count <= hour_count + 1;
                    
                    if (hour_count == 8'h12) begin
                        hour_count <= 8'b0000_0000;
                    end else if (hour_count > 8'h12) begin
                        hour_count <= 8'b0000_0001;
                    end
                end
            end else begin
                sec_count <= sec_count + 1;
            end
        end
    end
        
endmodule
