module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

    always @(*) begin
        // Set 'left' based on scancode
        if (scancode == 16'he06b) 
            left = 1;
        else 
            left = 0;

        // Set 'down' based on scancode
        if (scancode == 16'he072)
            down = 1;
        else 
            down = 0;

        // Set 'right' based on scancode
        if (scancode == 16'he074) 
            right = 1;
        else 
            right = 0;

        // Set 'up' based on scancode
        if (scancode == 16'he075)
            up = 1;
        else
            up = 0;
    end

endmodule
