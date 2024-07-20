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
    
    always @* begin
        next_state = state;
        
        case (state)
            2'b00: begin
                if (bump_left) begin
                    next_state = 2'b01;
                end
                if (bump_right) begin
                    next_state = 2'b10;
                end
            end
            2'b01: begin
                if (bump_right) begin
                    next_state = 2'b10;
                end
                if (!bump_left) begin
                    next_state = 2'b00;
                end
            end
            2'b10: begin
                if (bump_left) begin
                    next_state = 2'b01;
                end
                if (!bump_right) begin
                    next_state = 2'b00;
                end
            end
            default: begin
                next_state = 2'b10;
            end
        endcase
    end
    
    always @(state) begin
        case(state)
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
                walk_left = 1'b1;
                walk_right = 1'b0;
            end
        endcase
    end

endmodule
