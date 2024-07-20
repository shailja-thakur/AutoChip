module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    reg [1:0] state;

    // Moore state machine states
    parameter LEFT = 2'b00;
    parameter RIGHT = 2'b01;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= LEFT;  // Reset to walk left
        end else begin
            case (state)
                LEFT: begin
                    if (bump_right) begin
                        state <= RIGHT;  // Switch to walk right
                    end
                end
                RIGHT: begin
                    if (bump_left) begin
                        state <= LEFT;  // Switch to walk left
                    end
                end
            endcase
        end
    end

    // Moore state machine outputs
    assign walk_left = (state == LEFT);
    assign walk_right = (state == RIGHT);

endmodule
