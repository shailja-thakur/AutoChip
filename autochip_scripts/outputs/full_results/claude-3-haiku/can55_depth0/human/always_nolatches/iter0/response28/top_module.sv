module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

always @(*) begin
    left = 1'b0;
    down = 1'b0;
    right = 1'b0;
    up = 1'b0;
    
    case (scancode)
        16'h006b: left = 1'b1;
        16'h0072: down = 1'b1;
        16'h0074: right = 1'b1;
        16'h0075: up = 1'b1;
        default: ;
    endcase
end

endmodule
