module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output walk_left,
    output walk_right
);

    reg [1:0] state;
    reg walk_left;
    reg walk_right;

    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b01;
        end else begin
            case(state)
                2'b00: begin
                    if (bump_left) begin
                        state <= 2'b10;
                    end else if (bump_right) begin
                        state <= 2'b01;
                    end
                end
                
                2'b01: begin
                    if (bump_left && bump_right) begin
                        state <= 2'b10;
                    end else if (bump_left) begin
                        state <= 2'b01;
                    end
                end
                
                2'b10: begin
                    if (bump_left && bump_right) begin
                        state <= 2'b10;
                    end else if (bump_right) begin
                        state <= 2'b01;
                    end
                end
            endcase
        end
    end

    always @(*) begin
        case(state)
            2'b00: begin
                walk_left = 1;
                walk_right = 0;
            end
            2'b01: begin
                walk_left = 0;
                walk_right = 1;
            end
            2'b10: begin
                walk_left = 1;
                walk_right = 0;
            end
        endcase
    end

endmodule
