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
        if (areset) begin
            state <= 2'b10; // walking left
        end
        else begin
            case (state)
                2'b00: begin // walking right
                    if (bump_left && bump_right) begin
                        state <= 2'b10; // walking left
                    end
                    else if (bump_left) begin
                        state <= 2'b10; // walking left
                    end
                    else if (bump_right) begin
                        state <= 2'b01; // walking right
                    end
                end
                2'b01: begin // walking left
                    if (bump_left && bump_right) begin
                        state <= 2'b10; // walking left
                    end
                    else if (bump_left) begin
                        state <= 2'b10; // walking left
                    end
                    else if (bump_right) begin
                        state <= 2'b00; // walking right
                    end
                end
                default: begin // reset state
                    state <= 2'b10; // walking left
                end
            endcase
        end
    end

    always @(state) begin
        case (state)
            2'b00: begin // walking right
                walk_left <= 1'b0;
                walk_right <= 1'b1;
            end
            2'b01: begin // walking left
                walk_left <= 1'b1;
                walk_right <= 1'b0;
            end
            default: begin // default state
                walk_left <= 1'b1;
                walk_right <= 1'b0;
            end
        endcase
    end

endmodule
