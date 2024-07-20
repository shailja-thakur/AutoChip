module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    input ground,
    output reg walk_left,
    output reg walk_right,
    output reg aaah
);

    reg [1:0] state;

    always @(posedge clk or posedge areset) begin
        if(areset)
            state <= 2'b00;
        else
            case(state)
                2'b00: begin // walking left
                    if(bump_right)
                        state <= 2'b01; // switch direction
                    else if(ground == 0)
                        state <= 2'b10; // start falling
                end
                2'b01: begin // walking right
                    if(bump_left)
                        state <= 2'b00; // switch direction
                    else if(ground == 0)
                        state <= 2'b10; // start falling
                end
                2'b10: begin // falling
                    if(ground)
                        state <= (state == 2'b00) ? 2'b00 : 2'b01; // resume walking in the same direction
                end
            endcase
        end
    end

    always @(state) begin
        case(state)
            2'b00: begin // walking left
                walk_left = 1;
                walk_right = 0;
                aaah = 0;
            end
            2'b01: begin // walking right
                walk_left = 0;
                walk_right = 1;
                aaah = 0;
            end
            2'b10: begin // falling
                walk_left = 0;
                walk_right = 0;
                aaah = 1;
            end
        endcase
    end
endmodule
