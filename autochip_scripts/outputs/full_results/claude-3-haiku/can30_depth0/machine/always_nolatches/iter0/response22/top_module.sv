module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

always @(*) begin
    // Assign the outputs based on the scancode value
    case (scancode)
        16'h0E06B: left = 1;
        16'h0E072: down = 1;
        16'h0E074: right = 1;
        16'h0E075: up = 1;
        default: begin
            left = 0;
            down = 0;
            right = 0;
            up = 0;
        end
    endcase
end

endmodule
