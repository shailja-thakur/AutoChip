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

    // Check the scancode and set the corresponding output
    case (scancode)
        16'h0E06B: left = 1; // Left arrow
        16'h0E072: down = 1; // Down arrow
        16'h0E074: right = 1; // Right arrow
        16'h0E075: up = 1; // Up arrow
    endcase
end

endmodule
