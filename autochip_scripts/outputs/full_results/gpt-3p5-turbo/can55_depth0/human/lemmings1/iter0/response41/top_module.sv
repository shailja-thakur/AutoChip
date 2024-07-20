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
            state <= 2'b10; // Walking left state
        end else begin
            case (state)
                2'b10: begin // Walking left state
                    if (bump_right) begin
                        state <= 2'b01; // Walking right state
                    end
                end
                2'b01: begin // Walking right state
                    if (bump_left) begin
                        state <= 2'b10; // Walking left state
                    end
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            2'b10: begin // Walking left state
                walk_left = 1;
                walk_right = 0;
            end
            2'b01: begin // Walking right state
                walk_left = 0;
                walk_right = 1;
            end
        endcase
    end
    
endmodule
