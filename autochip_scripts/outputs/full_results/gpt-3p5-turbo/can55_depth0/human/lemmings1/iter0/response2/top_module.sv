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
            state <= 2'b10; // Initialize state to walk_left
        else begin
            case (state)
                2'b10: // walk_left state
                    if (bump_right)
                        state <= 2'b01; // switch to walk_right state
                2'b01: // walk_right state
                    if (bump_left)
                        state <= 2'b10; // switch to walk_left state
                default:
                    state <= 2'b10; // Default state is walk_left
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            2'b10: // walk_left state
                begin
                    walk_left = 1;
                    walk_right = 0;
                end
            2'b01: // walk_right state
                begin
                    walk_left = 0;
                    walk_right = 1;
                end
            default:
                begin
                    walk_left = 0;
                    walk_right = 0;
                end
        endcase
    end

endmodule
