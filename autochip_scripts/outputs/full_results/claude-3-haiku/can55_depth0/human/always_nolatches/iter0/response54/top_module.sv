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
        16'hE06B: left = 1;
        16'hE072: down = 1;
        16'hE074: right = 1;
        16'hE075: up = 1;
        default: ; // Do nothing
    endcase
end

endmodule
