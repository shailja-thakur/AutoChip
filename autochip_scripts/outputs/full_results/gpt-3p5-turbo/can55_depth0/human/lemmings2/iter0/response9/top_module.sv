module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output walk_left,
    output walk_right,
    output aaah
);

reg [1:0] state;
// Define state values
parameter LEFT = 2'b00;
parameter RIGHT = 2'b01;
parameter FALLING = 2'b10;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= LEFT; // Reset to initial state
    end else begin
        case(state)
            LEFT: begin
                if (bump_right) begin
                    state <= RIGHT;
                end else if (!ground) begin
                    state <= FALLING;
                end
            end
            RIGHT: begin
                if (bump_left) begin
                    state <= LEFT;
                end else if (!ground) begin
                    state <= FALLING;
                end
            end
            FALLING: begin
                if (ground) begin
                    if (state == LEFT) begin
                        state <= LEFT;
                    end else begin
                        state <= RIGHT;
                    end
                end
            end
        endcase
    end
end

// Output assignments
assign walk_left = (state == LEFT);
assign walk_right = (state == RIGHT);
assign aaah = !ground;

endmodule
