module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Parameter declaration
    parameter WL = 1'b0;	// WL represents state WL
    parameter WR = 1'b1;	// WR represents state WR
    
    // State register
    reg state;

    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WL;    // Reset to initial state
        else begin
            // Determine the next state based on current state and inputs
            case(state)
                WL: state <= (bump_left) ? WR : WL;
                WR: state <= (bump_right) ? WL : WR;
                default: state <= WL;    // Default to WL
            endcase
        end
    end
    
    // Output assignment
    always @(state) begin
        case(state)
            WL: begin
                walk_left  <= 1'b1;
                walk_right <= 1'b0;
            end
            WR: begin
                walk_left  <= 1'b0;
                walk_right <= 1'b1;
            end
            default: begin
                walk_left  <= 1'b1;    // Default to WL
                walk_right <= 1'b0;
            end
        endcase
    end
    
endmodule
