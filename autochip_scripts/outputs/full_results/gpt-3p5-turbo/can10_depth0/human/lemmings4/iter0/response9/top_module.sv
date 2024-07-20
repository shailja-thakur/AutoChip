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

always @(posedge clk or posedge areset)
    if (areset)
        state <= 1;
    else
        case(state)
            1: if (bump_left && !bump_right)
                    state <= 2;
                else if (!bump_left && bump_right)
                    state <= 3;
                else if (ground == 0)
                    state <= 4;
                else if (dig)
                    state <= 5;
                else
                    state <= 1;
            2: state <= 1;
            3: state <= 1;
            4: if (ground == 1)
                    state <= 1;
                else
                    state <= 4;
            5: if (ground == 0)
                    state <= 5;
                else
                    state <= 1;
        endcase

always @(state)
    case(state)
        1: begin
               walk_left = 1;
               walk_right = 0;
               aaah = 0;
               digging = 0;
           end
        2: begin
               walk_left = 0;
               walk_right = 1;
               aaah = 0;
               digging = 0;
           end
        3: begin
               walk_left = 1;
               walk_right = 0;
               aaah = 0;
               digging = 0;
           end
        4: begin
               walk_left = 0;
               walk_right = 0;
               aaah = 1;
               digging = 0;
           end
        5: begin
               walk_left = 0;
               walk_right = 0;
               aaah = 0;
               digging = 1;
           end
        default: begin
                    walk_left = 0;
                    walk_right = 0;
                    aaah = 0;
                    digging = 0;
                 end
    endcase

endmodule
