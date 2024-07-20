module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

// Define the states of the FSM
localparam [1:0] 
    STATE_IDLE = 2'b00,
    STATE_SEARCH1 = 2'b01,
    STATE_SEARCH2 = 2'b10,
    STATE_SEARCH3 = 2'b11;

// Declare the state register
reg [1:0] state, next_state;

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
    end
    else begin
        state <= next_state;
    end
end

// Next state and output logic
always @(*) begin
    next_state = state;
    start_shifting = 1'b0;

    case (state)
        STATE_IDLE: begin
            if (data == 1'b1) begin
                next_state = STATE_SEARCH1;
            end
            else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_SEARCH1: begin
            if (data == 1'b1) begin
                next_state = STATE_SEARCH2;
            end
            else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_SEARCH2: begin
            if (data == 1'b0) begin
                next_state = STATE_SEARCH3;
            end
            else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_SEARCH3: begin
            if (data == 1'b1) begin
                start_shifting = 1'b1;
                next_state = STATE_SEARCH3;
            end
            else begin
                next_state = STATE_IDLE;
            end
        end
        default: begin
            next_state = STATE_IDLE;
        end
    endcase
end

endmodule
