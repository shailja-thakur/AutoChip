module top_module (
    input clk,
    input aresetn,
    input x,
    output reg z
);

// Define the states of the Mealy-type finite state machine
parameter [1:0] 
    STATE_IDLE = 2'b00,
    STATE_ONE  = 2'b01,
    STATE_TWO  = 2'b10;

// Declare the state variable
reg [1:0] state, next_state;

always @(posedge clk or negedge aresetn) begin
    if (!aresetn) begin
        state <= STATE_IDLE;
        z <= 1'b0;
    end
    else begin
        state <= next_state;
        // Assign the output z based on the current state and input x
        case (state)
            STATE_IDLE: begin
                z <= 1'b0;
                if (x == 1'b1) begin
                    next_state = STATE_ONE;
                end
                else begin
                    next_state = STATE_IDLE;
                end
            end
            STATE_ONE: begin
                z <= 1'b0;
                if (x == 1'b0) begin
                    next_state = STATE_TWO;
                end
                else begin
                    next_state = STATE_ONE;
                end
            end
            STATE_TWO: begin
                if (x == 1'b1) begin
                    z <= 1'b1;
                    next_state = STATE_ONE;
                end
                else begin
                    z <= 1'b0;
                    next_state = STATE_IDLE;
                end
            end
            default: begin
                z <= 1'b0;
                next_state = STATE_IDLE;
            end
        endcase
    end
end

endmodule
