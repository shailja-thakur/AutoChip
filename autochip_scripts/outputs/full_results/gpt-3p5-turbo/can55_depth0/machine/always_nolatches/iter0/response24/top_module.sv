module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);
    always @* begin
		// If the 16-bit scancode is equal to 16'he06b, then the left is equal to 1, else the left is equal to 0.
        if (scancode == 16'he06b)
            left = 1;
        else
            left = 0;
        
		// If the 16-bit scancode is equal to 16'he072, then the down is equal to 1, else the down is equal to 0.
        if (scancode == 16'he072)
            down = 1;
        else
            down = 0;
        
		// If the 16-bit scancode is equal to 16'he074, then the right is equal to 1, else the right is equal to 0.
        if (scancode == 16'he074)
            right = 1;
        else
            right = 0;
        
		// If the 16-bit scancode is equal to 16'he075, then the up is equal to 1, else the up is equal to 0.
        if (scancode == 16'he075)
            up = 1;
        else
            up = 0;
    end
endmodule
