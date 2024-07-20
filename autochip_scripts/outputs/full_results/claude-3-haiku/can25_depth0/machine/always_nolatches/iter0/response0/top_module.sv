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
    if (scancode == 16'hE06B) begin
        left = 1;
    end
    if (scancode == 16'hE072) begin
        down = 1;
    end
    if (scancode == 16'hE074) begin
        right = 1;
    end
    if (scancode == 16'hE075) begin
        up = 1;
    end
end

endmodule
