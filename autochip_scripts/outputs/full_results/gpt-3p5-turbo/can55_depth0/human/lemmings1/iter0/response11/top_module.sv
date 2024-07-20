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
            state <= 2'b10;  // walking left state
        end else begin
            case (state)
                2'b10: begin  // walking left
                    if (bump_left || (bump_left && bump_right)) begin
                        state <= 2'b01;  // walking right state
                    end
                end
                2'b01: begin  // walking right
                    if (bump_right || (bump_left && bump_right)) begin
                        state <= 2'b10;  // walking left state
                    end
                end
                default: begin
                    state <= 2'b10;  // default state is walking left
                end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            2'b10: begin  // walking left
                walk_left <= 1;
                walk_right <= 0;
            end
            2'b01: begin  // walking right
                walk_left <= 0;
                walk_right <= 1;
            end
            default: begin
                walk_left <= 1;  // default state is walking left
                walk_right <= 0;
            end
        endcase
    end

endmodule
