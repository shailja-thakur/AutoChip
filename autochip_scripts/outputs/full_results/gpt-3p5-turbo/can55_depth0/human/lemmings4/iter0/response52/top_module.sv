module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    input dig,
    output reg walk_left,
    output reg walk_right,
    output reg aaah,
    output reg digging
);

    reg [5:0] state;
    reg [4:0] fall_counter;
    reg [4:0] dig_counter;
    
    parameter WALK_LEFT = 6'b000001;
    parameter WALK_RIGHT = 6'b000010;
    parameter FALL = 6'b000100;
    parameter DIG = 6'b001000;
    parameter SPLATTER = 6'b010000;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
            fall_counter <= 5'b0;
            dig_counter <= 5'b0;
            walk_left <= 1'b1;
            walk_right <= 1'b0;
            aaah <= 1'b0;
            digging <= 1'b0;
        end else begin
            case(state)
                WALK_LEFT: begin
                    if (bump_right && !bump_left) begin
                        state <= WALK_RIGHT;
                    end else if (bump_left && !bump_right) begin
                        state <= WALK_LEFT;
                    end else if (bump_left && bump_right) begin
                        state <= WALK_RIGHT;
                    end else if (!ground) begin
                        state <= FALL;
                    end else if (dig) begin
                        state <= DIG;
                    end
                end
                WALK_RIGHT: begin
                    if (!bump_right && bump_left) begin
                        state <= WALK_LEFT;
                    end else if (!bump_left && bump_right) begin
                        state <= WALK_RIGHT;
                    end else if (bump_left && bump_right) begin
                        state <= WALK_LEFT;
                    end else if (!ground) begin
                        state <= FALL;
                    end else if (dig) begin
                        state <= DIG;
                    end
                end
                FALL: begin
                    if (ground) begin
                        state <= WALK_LEFT;
                    end else if (fall_counter == 5'd20) begin
                        state <= SPLATTER;
                    end else begin
                        fall_counter <= fall_counter + 1;
                        state <= FALL;
                    end
                end
                DIG: begin
                    if (!ground) begin
                        state <= FALL;
                    end else if (dig_counter == 5'd20) begin
                        state <= SPLATTER;
                    end else begin
                        dig_counter <= dig_counter + 1;
                        state <= DIG;
                    end
                end
                SPLATTER: begin
                    state <= SPLATTER;
                end
            endcase
        end
    end
    
    always @(state) begin
        case(state)
            WALK_LEFT: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
            end
            WALK_RIGHT: begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
                aaah <= 1'b0;
                digging <= 1'b0;
            end
            FALL: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b1;
                digging <= 1'b0;
            end
            DIG: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b1;
            end
            SPLATTER: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
            end
            default: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
                aaah <= 1'b0;
                digging <= 1'b0;
            end
        endcase
    end

endmodule
