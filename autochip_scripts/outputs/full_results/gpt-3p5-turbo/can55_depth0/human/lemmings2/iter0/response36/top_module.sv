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

    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    parameter FALL = 2'b10;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WALK_LEFT;
        else begin
            case (state)
                WALK_LEFT: begin
                    if (bump_right)
                        state <= WALK_RIGHT;
                    else if (!ground)
                        state <= FALL;
                end

                WALK_RIGHT: begin
                    if (bump_left)
                        state <= WALK_LEFT;
                    else if (!ground)
                        state <= FALL;
                end

                FALL: begin
                    if (ground)
                        if (state == WALK_LEFT)
                            state <= WALK_LEFT;
                        else
                            state <= WALK_RIGHT;
                end
            endcase
        end
    end

    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = !ground && (state == FALL);
    
endmodule
