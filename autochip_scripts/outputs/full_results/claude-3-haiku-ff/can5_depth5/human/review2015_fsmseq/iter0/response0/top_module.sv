module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states
parameter [1:0] IDLE = 2'b00, SEARCH_1 = 2'b01, SEARCH_0 = 2'b10, FOUND = 2'b11;

// Declare the current and next state registers
reg [1:0] current_state, next_state;

// State transition logic
always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= IDLE;
        start_shifting <= 0;
    end
    else begin
        current_state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (current_state)
        IDLE: begin
            if (data == 1)
                next_state = SEARCH_1;
            else
                next_state = IDLE;
        end
        SEARCH_1: begin
            if (data == 0)
                next_state = SEARCH_0;
            else
                next_state = SEARCH_1;
        end
        SEARCH_0: begin
            if (data == 1)
                next_state = SEARCH_1;
            else
                next_state = FOUND;
        end
        FOUND: begin
            next_state = FOUND;
            start_shifting = 1;
        end
        default:
            next_state = IDLE;
    endcase
end

endmodule
