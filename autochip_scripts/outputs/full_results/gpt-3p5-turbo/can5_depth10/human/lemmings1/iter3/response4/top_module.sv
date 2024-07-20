module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    reg [1:0] state;
    reg [1:0] next_state;
    
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= 2'b10;
        end else begin
            state <= next_state;
        end
    end
    
    always @(state or bump_left or bump_right) begin
        case(state)
            2'b00: begin
                if (bump_left) begin
                    next_state <= 2'b01;
                    walk_left <= 0;
                    walk_right <= 1;
                end else if (bump_right) begin
                    next_state <= 2'b10;
                    walk_left <= 1;
                    walk_right <= 0;
                end else begin
                    next_state <= 2'b00;
                end
            end
            2'b01: begin
                if (bump_right) begin
                    next_state <= 2'b10;
                    walk_left <= 1;
                    walk_right <= 0;
                end else if (!bump_left && !bump_right) begin
                    next_state <= 2'b00;
                    walk_left <= 1;
                    walk_right <= 0;
                end else begin
                    next_state <= 2'b01;
                end
            end
            2'b10: begin
                if (bump_left) begin
                    next_state <= 2'b01;
                    walk_left <= 0;
                    walk_right <= 1;
                end else if (!bump_left && !bump_right) begin
                    next_state <= 2'b00;
                    walk_left <= 1;
                    walk_right <= 0;
                end else begin
                    next_state <= 2'b10;
                end
            end
            default: next_state <= 2'b00;
        endcase
    end

endmodule
