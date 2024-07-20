module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

always @(*) begin
    left = 0;
    down = 0;
    right = 0;
    up = 0;
    
    case (scancode)
        16'h0E6b: left = 1;
        16'h0E72: down = 1;
        16'h0E74: right = 1;
        16'h0E75: up = 1;
        default: begin
            left = 0;
            down = 0;
            right = 0;
            up = 0;
        end
    endcase
end

endmodule
