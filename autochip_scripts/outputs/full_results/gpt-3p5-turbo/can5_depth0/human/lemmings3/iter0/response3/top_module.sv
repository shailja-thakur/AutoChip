module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output walk_left,
    output walk_right,
    output aaah,
    output digging
);

    reg [1:0] state;

    // Define states
    parameter IDLE = 2'b00;
    parameter WALK_LEFT = 2'b01;
    parameter WALK_RIGHT = 2'b10;
    
    // Define output values
    reg walk_left_out;
    reg walk_right_out;
    reg aaah_out;
    reg digging_out;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= IDLE;
        end else begin
            case(state)
                IDLE: begin
                    if (bump_left && !bump_right) begin
                        state <= WALK_RIGHT;
                    end else if (bump_right && !bump_left) begin
                        state <= WALK_LEFT;
                    end else if (ground == 0) begin
                        state <= IDLE;
                    end else if (dig && ground == 1) begin
                        state <= WALK_LEFT;
                    end else begin
                        state <= IDLE;
                    end
                end
                WALK_LEFT: begin
                    if (bump_right && !bump_left) begin
                        state <= WALK_RIGHT;
                    end else if (ground == 0) begin
                        state <= IDLE;
                    end else if (dig && ground == 1) begin
                        state <= WALK_LEFT;
                    end else begin
                        state <= WALK_LEFT;
                    end
                end
                WALK_RIGHT: begin
                    if (bump_left && !bump_right) begin
                        state <= WALK_LEFT;
                    end else if (ground == 0) begin
                        state <= IDLE;
                    end else if (dig && ground == 1) begin
                        state <= WALK_RIGHT;
                    end else begin
                        state <= WALK_RIGHT;
                    end
                end
            endcase
        end
    end

    always @* begin
        case(state)
            IDLE: begin
                walk_left_out = 1'b0;
                walk_right_out = 1'b0;
                aaah_out = 1'b0;
                digging_out = 1'b0;
            end
            WALK_LEFT: begin
                walk_left_out = 1'b1;
                walk_right_out = 1'b0;
                aaah_out = 1'b0;
                digging_out = 1'b0;
            end
            WALK_RIGHT: begin
                walk_left_out = 1'b0;
                walk_right_out = 1'b1;
                aaah_out = 1'b0;
                digging_out = 1'b0;
            end
        endcase
    end

    assign walk_left = walk_left_out;
    assign walk_right = walk_right_out;
    assign aaah = aaah_out;
    assign digging = digging_out;

endmodule
