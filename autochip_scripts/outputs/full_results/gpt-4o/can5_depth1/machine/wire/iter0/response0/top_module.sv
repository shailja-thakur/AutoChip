module top_module (
    input wire clk,
    input wire reset,
    output reg data_out,
    output reg valid_out
);

    // State Encoding
    typedef enum logic [1:0] {
        IDLE    = 2'b00,
        WAIT    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;

    // Internal Signals
    state_t state, next_state;
    reg [3:0] counter;

    // FSM State Transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0;
        end else begin
            state <= next_state;
            if (state == WAIT)
                counter <= counter + 1;
            else
                counter <= 4'b0;
        end
    end

    // Next State Logic and Output Logic
    always_comb begin
        next_state = state; // default assignment
        data_out = 1'b0;
        valid_out = 1'b0;

        case (state)
            IDLE: begin
                if (reset) begin
                    counter = 4'b0;
                end
                next_state = WAIT;
            end

            WAIT: begin
                if (counter == 4'b1111) begin
                    next_state = PROCESS;
                end
            end

            PROCESS: begin
                data_out = 1'b1; // Example data processing
                next_state = DONE;
            end

            DONE: begin
                valid_out = 1'b1;
                next_state = IDLE;
            end
        endcase
    end
endmodule
