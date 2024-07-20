module top_module (
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

// State encoding
typedef enum logic [1:0] {
    IDLE    = 2'b00,
    WAIT    = 2'b01,
    PROCESS = 2'b10,
    DONE    = 2'b11
} state_t;

state_t state, next_state;
reg [7:0] counter;

// FSM state transition
always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
    end else begin
        state <= next_state;
    end
end

// FSM next state logic and outputs
always_comb begin
    // Default values
    next_state = state;
    data_out = 8'b0;
    valid_out = 1'b0;

    case (state)
        IDLE: begin
            counter = 8'b0;
            if (!reset)
                next_state = WAIT;
        end

        WAIT: begin
            counter = counter + 1;
            if (counter == 8'hFF) // Threshold can be adjusted
                next_state = PROCESS;
        end

        PROCESS: begin
            data_out = counter; // Processed data will be based on the counter
            next_state = DONE;
        end

        DONE: begin
            valid_out = 1'b1;
            next_state = IDLE;
        end
    endcase
end

endmodule
