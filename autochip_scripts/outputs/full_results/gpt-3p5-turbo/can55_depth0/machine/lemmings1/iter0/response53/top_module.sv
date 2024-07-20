module top_module (
    input clk,
    input areset,
    input bump_left,
    input bump_right,
    output reg walk_left,
    output reg walk_right
);

    // Define parameters
    parameter WL = 0;
    parameter WR = 1;

    // Define registers
    reg [1:0] state;
    reg next_state;

    // Synchronous always block to update the state machine
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= WL;
        else
            state <= next_state;
    end

    // Combinational always block to determine next state and update outputs
    always @(*) begin
        case (state)
            WL: begin
                if (bump_left)
                    next_state = WR;
                else
                    next_state = WL;
                
                walk_left = 1;
                walk_right = 0;
            end
            
            WR: begin
                if (bump_right)
                    next_state = WL;
                else
                    next_state = WR;
                
                walk_left = 0;
                walk_right = 1;
            end
        endcase
    end

endmodule
