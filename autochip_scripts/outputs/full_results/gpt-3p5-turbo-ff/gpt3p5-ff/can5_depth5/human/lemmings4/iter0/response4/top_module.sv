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

    reg [4:0] state;

    // Define the states
    parameter WALK_LEFT = 5'b00001;
    parameter WALK_RIGHT = 5'b00010;
    parameter FALL = 5'b00100;
    parameter DIG = 5'b01000;
    parameter SPLATTER = 5'b10000;
  
    always @(posedge clk or posedge areset) begin
        if (areset == 1) begin
            state <= WALK_LEFT;
        end else begin
            case (state)
                WALK_LEFT:
                    if (bump_right == 1 && bump_left == 0) begin
                        state <= WALK_RIGHT;
                    end else if (dig == 1 && ground == 1) begin
                        state <= DIG;
                    end else if (ground == 0) begin
                        state <= FALL;
                    end
                WALK_RIGHT:
                    if (bump_right == 0 && bump_left == 1) begin
                        state <= WALK_LEFT;
                    end else if (dig == 1 && ground == 1) begin
                        state <= DIG;
                    end else if (ground == 0) begin
                        state <= FALL;
                    end
                DIG:
                    if (dig == 0 || ground == 0) begin
                        state <= FALL;
                    end else if (ground == 1 && dig == 1) begin
                        state <= DIG;
                    end
                FALL:
                    if (ground == 1) begin
                        if (bump_right == 1 || bump_left == 1 || (dig == 1 && ground == 0)) begin
                            state <= FALL;
                        end else if (bump_right == 0 && bump_left == 0 && dig == 0 && ground == 1) begin
                            state <= WALK_LEFT;
                        end
                    end else if (state == 20'b10100 && ground == 0) begin
                        state <= SPLATTER;
                    end else begin
                        state <= FALL;
                    end
                SPLATTER:
                    state <= SPLATTER;
            endcase
        end
    end

    // Output assignments based on current state
    always @(state) begin
        case (state)
            WALK_LEFT:
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
                digging = 0;
            WALK_RIGHT:
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
                digging = 0;
            DIG:
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 1;
            FALL:
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
                digging = 0;
            SPLATTER:
                walk_left = 0;
                walk_right = 0;
                aaah = 0;
                digging = 0;
        endcase
    end
endmodule
