module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

    always @*
    begin
        left = (scancode == 16'b111000011011) ? 1 : 0;
        down = (scancode == 16'b111000011110) ? 1 : 0;
        right = (scancode == 16'b111000011100) ? 1 : 0;
        up = (scancode == 16'b111000011101) ? 1 : 0;
    end

endmodule
