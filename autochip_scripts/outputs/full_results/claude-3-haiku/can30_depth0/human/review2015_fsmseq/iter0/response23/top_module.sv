module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states of the finite-state machine
parameter [1:0] 
    IDLE = 2'b00,
    SEARCH_1 = 2'b01,
    SEARCH_10 = 2'b10,
    SEARCH_101 = 2'b11;

// Internal state register
reg [1:0] state, next_state;

always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        start_shifting <= 0;
    end
    else begin
        state <= next_state;
        if (state == SEARCH_101 && data == 1)
            start_shifting <= 1;
    end
end

always @(*) begin
    case (state)
        IDLE: begin
            if (data == 1)
                next_state = SEARCH_1;
            else
                next_state = IDLE;
        end
        SEARCH_1: begin
            if (data == 0)
                next_state = SEARCH_10;
            else
                next_state = SEARCH_1;
        end
        SEARCH_10: begin
            if (data == 1)
                next_state = SEARCH_101;
            else
                next_state = IDLE;
        end
        SEARCH_101: begin
            if (data == 0)
                next_state = IDLE;
            else
                next_state = SEARCH_1;
        end
    endcase
end

endmodule
