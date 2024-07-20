module top_module (
    input [15:0] scancode,
    output reg left,
    output reg down,
    output reg right,
    output reg up
);

always @(*) begin
    // Initialize all outputs to 0
    left = 1'b0;
    down = 1'b0;
    right = 1'b0;
    up = 1'b0;

    // Check the scancode and set the corresponding output
    case (scancode)
        16'h0e06b: left = 1'b1;
        16'h0e072: down = 1'b1;
        16'h0e074: right = 1'b1;
        16'h0e075: up = 1'b1;
        default: begin
            // Do nothing, keep all outputs at 0
        end
    endcase
end

endmodule
