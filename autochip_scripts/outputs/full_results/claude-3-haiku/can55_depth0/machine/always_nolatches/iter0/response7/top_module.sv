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

    // Check scancode values and set outputs accordingly
    case (scancode)
        16'h006b: left = 1;
        16'h0072: down = 1;
        16'h0074: right = 1;
        16'h0075: up = 1;
        default: ; // Do nothing
    endcase
end

endmodule
