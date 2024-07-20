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

    // Check the scancode and set the corresponding outputs
    if (scancode == 16'hE06B) begin
        left = 1'b1;
    end else if (scancode == 16'hE072) begin
        down = 1'b1;
    end else if (scancode == 16'hE074) begin
        right = 1'b1;
    end else if (scancode == 16'hE075) begin
        up = 1'b1;
    end
end

endmodule
