module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

reg [1:0] state;
reg walk_left;
reg walk_right;

parameter WALK_LEFT = 2'b00;
parameter WALK_RIGHT = 2'b01;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        case (state)
            WALK_LEFT: begin
                if (bump_left || (bump_left && bump_right)) begin
                    state <= WALK_RIGHT;
                end
            end
            WALK_RIGHT: begin
                if (bump_right || (bump_left && bump_right)) begin
                    state <= WALK_LEFT;
                end
            end
        endcase
    end
end

always @(*) begin
    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
        end
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
        end
    endcase
end

endmodule
