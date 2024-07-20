module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

always @(*) begin
    // Default values
    left = 0;
    down = 0;
    right = 0;
    up = 0;

    // Check scancode and set the appropriate output
    if (scancode == 16'he06b) begin
        left = 1;
    end
    else if (scancode == 16'he072) begin
        down = 1;
    end
    else if (scancode == 16'he074) begin
        right = 1;
    end
    else if (scancode == 16'he075) begin
        up = 1;
    end
end

endmodule
