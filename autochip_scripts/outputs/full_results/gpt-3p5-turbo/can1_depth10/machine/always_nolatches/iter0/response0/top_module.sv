module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

    // Check if the scancode is equal to 16'he06b
    always @(scancode) begin
        if (scancode == 16'he06b) begin
            left <= 1;
        end
        else begin
            left <= 0;
        end
    end
    
    // Check if the scancode is equal to 16'he072
    always @(scancode) begin
        if (scancode == 16'he072) begin
            down <= 1;
        end
        else begin
            down <= 0;
        end
    end
    
    // Check if the scancode is equal to 16'he074
    always @(scancode) begin
        if (scancode == 16'he074) begin
            right <= 1;
        end
        else begin
            right <= 0;
        end
    end
    
    // Check if the scancode is equal to 16'he075
    always @(scancode) begin
        if (scancode == 16'he075) begin
            up <= 1;
        end
        else begin
            up <= 0;
        end
    end

endmodule
