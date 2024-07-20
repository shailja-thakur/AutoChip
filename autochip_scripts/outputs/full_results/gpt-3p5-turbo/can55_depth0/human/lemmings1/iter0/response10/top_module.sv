module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define states
    parameter WALK_LEFT = 1'b0;
    parameter WALK_RIGHT = 1'b1;

    // Define current state variable
    reg [1:0] state;

    // Define output logic
    always @ (posedge clk or posedge areset) begin
        if (areset) begin
            state <= WALK_LEFT;
        end else begin
            case (state)
                WALK_LEFT: begin
                    if (bump_right) begin
                        state <= WALK_RIGHT;
                    end
                end
                WALK_RIGHT: begin
                    if (bump_left) begin
                        state <= WALK_LEFT;
                    end
                end
                default: begin
                    state <= WALK_LEFT;
                end
            endcase
        end
    end

    // Define output logic
    always @ (state) begin
        case (state)
            WALK_LEFT: begin
                walk_left <= 1'b1;
                walk_right <= 1'b0;
            end
            WALK_RIGHT: begin
                walk_left <= 1'b0;
                walk_right <= 1'b1;
            end
            default: begin
                walk_left <= 1'b0;
                walk_right <= 1'b0;
            end
        endcase
    end

endmodule
