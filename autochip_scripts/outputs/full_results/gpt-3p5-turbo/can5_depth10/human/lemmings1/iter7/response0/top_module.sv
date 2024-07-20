module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    reg [1:0] state;
    reg temp_walk_left;
    reg temp_walk_right;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10;
        end else if (state == 2'b00) begin
            if (bump_left && !bump_right) begin
                state <= 2'b01;
            end else if (!bump_left && bump_right) begin
                state <= 2'b10;
            end
        end else if (state == 2'b01) begin
            if (bump_right && !bump_left) begin
                state <= 2'b10;
            end else if (!bump_left && !bump_right) begin
                state <= 2'b00;
            end
        end else if (state == 2'b10) begin
            if (bump_left && !bump_right) begin
                state <= 2'b01;
            end else if (!bump_left && !bump_right) begin
                state <= 2'b00;
            end
        end
    end
    
    always @(posedge clk) begin
        case(state)
            2'b00: begin
                temp_walk_left = 1'b1;
                temp_walk_right = 1'b0;
            end
            2'b01: begin
                temp_walk_left = 1'b0;
                temp_walk_right = 1'b1;
            end
            2'b10: begin
                temp_walk_left = 1'b1;
                temp_walk_right = 1'b0;
            end
            default: begin
                temp_walk_left = 1'b1;
                temp_walk_right = 1'b0;
            end
        endcase
    end
    
    always @(posedge clk) begin
        walk_left <= temp_walk_left;
        walk_right <= temp_walk_right;
    end

endmodule
