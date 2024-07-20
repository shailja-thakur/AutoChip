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

        // Check for each scancode and set the respective output to 1
        if (scancode == 16'hE06B)
            left = 1;
        else if (scancode == 16'hE072)
            down = 1;
        else if (scancode == 16'hE074)
            right = 1;
        else if (scancode == 16'hE075)
            up = 1;
    end

endmodule
