module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

    // Check for left arrow
    always @* begin
        if (scancode == 16'hE06B)
            left = 1;
        else
            left = 0;
    end

    // Check for down arrow
    always @* begin
        if (scancode == 16'hE072)
            down = 1;
        else
            down = 0;
    end

    // Check for right arrow
    always @* begin
        if (scancode == 16'hE074)
            right = 1;
        else
            right = 0;
    end

    // Check for up arrow
    always @* begin
        if (scancode == 16'hE075)
            up = 1;
        else
            up = 0;
    end

endmodule
