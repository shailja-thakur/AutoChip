module top_module (
	input [15:0] scancode,
	output reg left,
	output reg down,
	output reg right,
	output reg up
);

always @(*) begin
    // Set the default values
    left = 0;
    down = 0;
    right = 0;
    up = 0;

    // Update the outputs based on the scancode
    case (scancode)
        16'he06b: left = 1;
        16'he072: down = 1;
        16'he074: right = 1;
        16'he075: up = 1;
        default: ;  // keep defaults if no match
    endcase
end

endmodule
