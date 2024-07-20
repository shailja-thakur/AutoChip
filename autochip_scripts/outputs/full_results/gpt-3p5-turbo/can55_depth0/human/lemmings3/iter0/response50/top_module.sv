module top_module (
	input clk,
	input areset,
	input bump_left,
	input bump_right,
	input ground,
	input dig,
	output wire walk_left,
	output wire walk_right,
	output wire aaah,
	output wire digging
);
    reg [1:0] state;
    
    // Define states
    parameter WALK_LEFT = 2'b00;
    parameter WALK_RIGHT = 2'b01;
    parameter FALL = 2'b10;
    parameter DIG = 2'b11;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT; // Reset state
        end else begin
            case (state)
                WALK_LEFT:
                    if (bump_right) begin
                        state <= WALK_RIGHT;
                    end else if (!ground) begin
                        state <= FALL;
                    end else if (dig) begin
                        state <= DIG;
                    end
                WALK_RIGHT:
                    if (bump_left) begin
                        state <= WALK_LEFT;
                    end else if (!ground) begin
                        state <= FALL;
                    end else if (dig) begin
                        state <= DIG;
                    end
                FALL:
                    if (ground) begin
                        if (state == DIG) begin
                            state <= FALL;
                        end else if (state == WALK_LEFT) begin
                            state <= WALK_LEFT;
                        end else if (state == WALK_RIGHT) begin
                            state <= WALK_RIGHT;
                        end
                    end
                DIG:
                    if (!ground) begin
                        state <= FALL;
                    end else if (!dig) begin
                        if (state == WALK_LEFT) begin
                            state <= WALK_LEFT;
                        end else if (state == WALK_RIGHT) begin
                            state <= WALK_RIGHT;
                        end
                    end
            endcase
        end
    end
    
    // Define outputs based on state
    assign walk_left = (state == WALK_LEFT);
    assign walk_right = (state == WALK_RIGHT);
    assign aaah = (state == FALL);
    assign digging = (state == DIG);

endmodule
