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
            state <= 2'b01; // Start in "walk_left" state
        end else begin
            case (state)
                2'b00: // "Switching direction" state
                    if (bump_left && bump_right) begin
                        state <= 2'b01; // Switch to "walk_left" state
                    end else if (bump_left) begin
                        state <= 2'b10; // Switch to "walk_right" state
                    end else if (bump_right) begin
                        state <= 2'b01; // Switch to "walk_left" state
                    end
                2'b01: // "walk_left" state
                    if (bump_right) begin
                        state <= 2'b10; // Switch to "walk_right" state
                    end
                2'b10: // "walk_right" state
                    if (bump_left) begin
                        state <= 2'b01; // Switch to "walk_left" state
                    end
            endcase
        end
    end
    
    always @(state) begin
        case (state)
            2'b00: // "Switching direction" state
                walk_left <= 1'b0;
                walk_right <= 1'b0;
            2'b01: // "walk_left" state
                walk_left <= 1'b1;
                walk_right <= 1'b0;
            2'b10: // "walk_right" state
                walk_left <= 1'b0;
                walk_right <= 1'b1;
        endcase
    end
endmodule
