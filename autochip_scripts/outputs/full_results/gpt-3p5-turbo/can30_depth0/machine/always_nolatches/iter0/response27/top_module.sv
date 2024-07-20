module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);
    always @(*) begin
        // Check for UP arrow
        if (scancode == 16'he075)
            up = 1;
        else
            up = 0;
        
        // Check for LEFT arrow
        if (scancode == 16'he06b)
            left = 1;
        else
            left = 0;
        
        // Check for DOWN arrow
        if (scancode == 16'he072)
            down = 1;
        else
            down = 0;
        
        // Check for RIGHT arrow
        if (scancode == 16'he074)
            right = 1;
        else
            right = 0;
    end
endmodule
