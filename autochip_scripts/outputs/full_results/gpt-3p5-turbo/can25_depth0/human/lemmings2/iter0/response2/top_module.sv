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
    parameter IDLE = 2'b00;
    parameter WALK_LEFT = 2'b01;
    parameter WALK_RIGHT = 2'b10;
    
    always @(posedge clk or posedge areset) begin
        if(areset) begin
            state <= WALK_LEFT;
        end
        else begin
            case(state)
                IDLE: begin
                    if(bump_left == 1 && bump_right == 0)
                        state <= WALK_RIGHT;
                    else if(bump_left == 0 && bump_right == 1)
                        state <= WALK_LEFT;
                    else if(bump_left == 1 && bump_right == 1)
                        state <= WALK_RIGHT;
                end
                WALK_LEFT: begin
                    if(bump_left == 1 && bump_right == 0)
                        state <= WALK_RIGHT;
                    else if(ground == 0)
                        state <= IDLE;
                end
                WALK_RIGHT: begin
                    if(bump_left == 0 && bump_right == 1)
                        state <= WALK_LEFT;
                    else if(ground == 0)
                        state <= IDLE;
                end
            endcase
        end
    end

    always @(state) begin
        case(state)
            IDLE: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
                aaah = 1'b0;
            end
            WALK_LEFT: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
                aaah = 1'b0;
            end
            WALK_RIGHT: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
                aaah = 1'b0;
            end
        endcase
    end

endmodule
