module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

    // Always block to monitor scancode input and determine arrow key presses
    always @(*) begin
        // Default values for all outputs
        left = 0;
        down = 0;
        right = 0;
        up = 0;

        // Decode the scancode using a case statement
        case(scancode)
            16'he06b: left = 1;  // left arrow
            16'he072: down = 1;  // down arrow
            16'he074: right = 1; // right arrow
            16'he075: up = 1;    // up arrow
            default: ;           // All outputs are already set to 0 by default
        endcase
    end

endmodule
