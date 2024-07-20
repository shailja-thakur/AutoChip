module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);
    reg [1:0] state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00;
        else
            case (state)
                2'b00: begin
                    if (bump_left & !bump_right)
                        state <= 2'b01;
                    else if (bump_right & !bump_left)
                        state <= 2'b10;
                end
                2'b01: begin
                    if (!bump_left & !bump_right)
                        state <= 2'b00;
                end
                2'b10: begin
                    if (!bump_left & !bump_right)
                        state <= 2'b00;
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            2'b00: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
            2'b01: begin
                walk_left = 1'b0;
                walk_right = 1'b1;
            end
            2'b10: begin
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
            default: begin
                walk_left = 1'b0;
                walk_right = 1'b0;
            end
        endcase
    end
endmodule
