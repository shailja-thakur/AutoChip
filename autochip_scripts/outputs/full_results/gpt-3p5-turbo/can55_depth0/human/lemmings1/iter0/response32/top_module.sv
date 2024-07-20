module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    reg [1:0] state;
    reg walk_left_internal;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= 2'b00;
        else begin
            case (state)
                2'b00: begin
                    if (bump_left && !bump_right)
                        state <= 2'b10;
                    else if (!bump_left && bump_right)
                        state <= 2'b01;
                    else if (bump_left && bump_right)
                        state <= 2'b11;
                end
                2'b01: begin
                    if (bump_left && !bump_right)
                        state <= 2'b10;
                    else if (!bump_left && !bump_right)
                        state <= 2'b00;
                    else if (bump_left && bump_right)
                        state <= 2'b11;
                end
                2'b10: begin
                    if (!bump_left && bump_right)
                        state <= 2'b01;
                    else if (!bump_left && !bump_right)
                        state <= 2'b00;
                    else if (bump_left && bump_right)
                        state <= 2'b11;
                end
                2'b11: begin
                    if (bump_left && !bump_right)
                        state <= 2'b10;
                    else if (!bump_left && bump_right)
                        state <= 2'b01;
                    else if (!bump_left && !bump_right)
                        state <= 2'b00;
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            2'b00: begin
                walk_left_internal <= 1'b1;
            end
            2'b01: begin
                walk_left_internal <= 1'b0;
            end
            2'b10: begin
                walk_left_internal <= 1'b1;
            end
            2'b11: begin
                walk_left_internal <= 1'b0;
            end
        endcase
    end

    assign walk_left = walk_left_internal;
    assign walk_right = ~walk_left_internal;

endmodule
