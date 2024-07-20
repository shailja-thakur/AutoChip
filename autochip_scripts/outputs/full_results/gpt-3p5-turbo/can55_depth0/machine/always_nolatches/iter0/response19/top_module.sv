module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);
    reg [15:0] constant_scancode = 16'he06b;
    reg [15:0] constant_scancode2 = 16'he072;
    reg [15:0] constant_scancode3 = 16'he074;
    reg [15:0] constant_scancode4 = 16'he075;

    always @(scancode) begin
        if (scancode == constant_scancode)
            left = 1;
        else
            left = 0;
        
        if (scancode == constant_scancode2)
            down = 1;
        else
            down = 0;
        
        if (scancode == constant_scancode3)
            right = 1;
        else
            right = 0;
        
        if (scancode == constant_scancode4)
            up = 1;
        else
            up = 0;
    end
endmodule
