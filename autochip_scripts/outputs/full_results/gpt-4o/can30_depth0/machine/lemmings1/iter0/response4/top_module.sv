module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // State encoding
    parameter WL = 1'b0, WR = 1'b1;
    
    // State register
    reg state, next_state;

    // Combinational logic to determine next state
    always @(*) begin
        case (state)
            WL: next_state = bump_left ? WR : WL;
            WR: next_state = bump_right ? WL : WR;
            default: next_state = WL; // Default state on any unexpected condition
        endcase
    end

    // Sequential logic to update state on clock edge or reset
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WL;
        else
            state <= next_state;
    end

    // Output logic based on current state
    always @(*) begin
        case (state)
            WL: begin
                walk_left = 1;
                walk_right = 0;
            end
            WR: begin
                walk_left = 0;
                walk_right = 1;
            end
            default: begin
                walk_left = 0;
                walk_right = 0;
            end
        endcase
    end

endmodule
