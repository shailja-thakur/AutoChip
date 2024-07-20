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
reg walk_left;
reg walk_right;
reg aaah;
reg digging;

parameter LEFT = 2'b00;
parameter RIGHT = 2'b01;
parameter FALL = 2'b10;
parameter DIG = 2'b11;

always @(posedge clk or posedge areset) begin
    if (areset) begin
        state <= LEFT;
        walk_left <= 1;
        walk_right <= 0;
        aaah <= 0;
        digging <= 0;
    end else begin
        case (state)
            LEFT: begin
                if (bump_left && !bump_right)
                    state <= RIGHT;
                else if (ground == 0)
                    state <= FALL;
                else if (dig && ground && !fall)
                    state <= DIG;
            end
            
            RIGHT: begin
                if (!bump_left && bump_right)
                    state <= LEFT;
                else if (ground == 0)
                    state <= FALL;
                else if (dig && ground && !fall)
                    state <= DIG;
            end
            
            FALL: begin
                if (ground)
                    state <= state == LEFT ? LEFT : RIGHT;
            end
            
            DIG: begin
                if (ground == 0)
                    state <= FALL;
            end
        endcase
    end
end

always @(state) begin
    case (state)
        LEFT: begin
            walk_left <= 1;
            walk_right <= 0;
            aaah <= 0;
            digging <= 0;
        end
        
        RIGHT: begin
            walk_left <= 0;
            walk_right <= 1;
            aaah <= 0;
            digging <= 0;
        end
        
        FALL: begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 1;
            digging <= 0;
        end
        
        DIG: begin
            walk_left <= 0;
            walk_right <= 0;
            aaah <= 0;
            digging <= 1;
        end
    endcase
end

endmodule
