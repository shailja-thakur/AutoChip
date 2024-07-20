module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

always @(*) begin
    // Set the output signals based on the scancode
    case (scancode)
        16'he06b: left = 1; // Left arrow pressed
        default: left = 0;
    endcase

    case (scancode)
        16'he072: down = 1; // Down arrow pressed
        default: down = 0;
    endcase

    case (scancode)
        16'he074: right = 1; // Right arrow pressed
        default: right = 0;
    endcase

    case (scancode)
        16'he075: up = 1; // Up arrow pressed
        default: up = 0;
    endcase
end

endmodule
