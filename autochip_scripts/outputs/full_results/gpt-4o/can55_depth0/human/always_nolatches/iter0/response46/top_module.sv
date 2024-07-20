module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

always @(*) begin
    // Default to none of the arrow keys being pressed
    left  = 0;
    down  = 0;
    right = 0;
    up    = 0;
    
    case (scancode)
        16'he06b: left  = 1; // left arrow
        16'he072: down  = 1; // down arrow
        16'he074: right = 1; // right arrow
        16'he075: up    = 1; // up arrow
        default: begin
            left  = 0;
            down  = 0;
            right = 0;
            up    = 0;
        end
    endcase
end

endmodule
