module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

    always @(*)
    begin
        case (scancode)
            16'he06b: {left, down, right, up} = 4'b1000;  // left arrow
            16'he072: {left, down, right, up} = 4'b0100;  // down arrow
            16'he074: {left, down, right, up} = 4'b0010;  // right arrow
            16'he075: {left, down, right, up} = 4'b0001;  // up arrow
            default: {left, down, right, up} = 4'b0000;   // none
        endcase
    end

endmodule
