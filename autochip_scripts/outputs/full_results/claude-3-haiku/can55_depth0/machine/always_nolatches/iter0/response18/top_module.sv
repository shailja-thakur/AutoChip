module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

always @(*) begin
    // Initialize outputs to 0
    left = 0;
    down = 0;
    right = 0;
    up = 0;

    // Check scancode and set corresponding output
    case (scancode)
        16'h0E06B: // Left arrow
            left = 1;
        16'h0E072: // Down arrow
            down = 1;
        16'h0E074: // Right arrow
            right = 1;
        16'h0E075: // Up arrow
            up = 1;
        default:
            ; // Do nothing
    endcase
end

endmodule
