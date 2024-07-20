module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

    always @(*) begin
        // Initialize all outputs to 0
        left = 0;
        down = 0;
        right = 0;
        up = 0;
        
        // Check scancode and set corresponding output
        if (scancode == 16'he06b)
            left = 1;
        else if (scancode == 16'he072)
            down = 1;
        else if (scancode == 16'he074)
            right = 1;
        else if (scancode == 16'he075)
            up = 1;
    end

endmodule
