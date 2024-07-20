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

reg [4:0] state;
wire fallTimer;

// State definitions
parameter WALK_LEFT = 3'b000;
parameter WALK_RIGHT = 3'b001;
parameter FALL = 3'b010;
parameter DIG = 3'b011;
parameter SPLATTER = 3'b100;

// Next state logic
always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= WALK_LEFT;
    end else begin
        case (state)
            WALK_LEFT: begin
                if (bump_right) begin
                    state <= WALK_RIGHT;
                end else if (bump_left) begin
                    state <= WALK_LEFT;
                end else if (!ground) begin
                    state <= FALL;
                end else if (dig) begin
                    state <= DIG;
                end else begin
                    state <= WALK_LEFT;
                end
            end
            
            WALK_RIGHT: begin
                if (bump_left) begin
                    state <= WALK_LEFT;
                end else if (bump_right) begin
                    state <= WALK_RIGHT;
                end else if (!ground) begin
                    state <= FALL;
                end else if (dig) begin
                    state <= DIG;
                end else begin
                    state <= WALK_RIGHT;
                end
            end
            
            FALL: begin
                if (ground) begin
                    if (fallTimer >= 5'd20) begin
                        state <= SPLATTER;
                    end else begin
                        state <= WALK_LEFT;
                    end
                end else if (dig) begin
                    state <= DIG;
                end else begin
                    state <= FALL;
                end
            end
            
            DIG: begin
                if (!ground) begin
                    state <= FALL;
                end else if (dig) begin
                    state <= DIG;
                end else if (bump_left && !fallTimer) begin
                    state <= WALK_LEFT;
                end else if (bump_right && !fallTimer) begin
                    state <= WALK_RIGHT;
                end else begin
                    state <= DIG;
                end
            end
            
            SPLATTER: begin
                state <= SPLATTER;
            end
        endcase
    end
end

// Output logic
always @(state) begin
    case (state)
        WALK_LEFT: begin
            walk_left = 1;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
        
        WALK_RIGHT: begin
            walk_left = 0;
            walk_right = 1;
            aaah = 0;
            digging = 0;
        end
        
        FALL: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 1;
            digging = 0;
        end
        
        DIG: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 1;
        end
        
        SPLATTER: begin
            walk_left = 0;
            walk_right = 0;
            aaah = 0;
            digging = 0;
        end
    endcase
end

// Falling timer
always @(posedge clk, posedge areset) begin
    if (areset || ground) begin
        fallTimer <= 0;
    end else begin
        fallTimer <= fallTimer + 1;
    end
end

endmodule
