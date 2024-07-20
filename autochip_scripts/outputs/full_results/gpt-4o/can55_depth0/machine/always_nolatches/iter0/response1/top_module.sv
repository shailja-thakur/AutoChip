module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

    always @(*) begin
        // Default values
        left  = 1'b0;
        down  = 1'b0;
        right = 1'b0;
        up    = 1'b0;

        // Check scancode and set the corresponding output
        if (scancode == 16'he06b) 
            left = 1'b1;
        else if (scancode == 16'he072) 
            down = 1'b1;
        else if (scancode == 16'he074) 
            right = 1'b1;
        else if (scancode == 16'he075) 
            up = 1'b1;
    end

endmodule
