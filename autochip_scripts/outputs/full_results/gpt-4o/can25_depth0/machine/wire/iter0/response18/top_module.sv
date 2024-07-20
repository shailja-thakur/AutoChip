module top_module(
    input clk,
    input reset,
    output reg data_out,
    output reg valid_out
);
    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    reg [3:0] counter;

    // State transition
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
            data_out <= 0;
            valid_out <= 0;
        end else begin
            state <= next_state;
            if (state == WAIT) begin
                counter <= counter + 1;
            end else begin
                counter <= 0;
            end
        end
    end

    // Next state logic and output logic
    always @ (*) begin
        next_state = state;
        case (state)
            IDLE: begin
                data_out = 0;
                valid_out = 0;
                if (reset == 0)
                    next_state = WAIT;
            end
            WAIT: begin
                data_out = 0;
                valid_out = 0;
                if (counter == 4'b1111) // Specify your threshold here
                    next_state = PROCESS;
            end
            PROCESS: begin
                data_out = 1; // This is a placeholder for actual processing logic
                valid_out = 0;
                next_state = DONE;
            end
            DONE: begin
                data_out = 1; // This is a placeholder for actual processed data
                valid_out = 1;
                next_state = IDLE;
            end
        endcase
    end
endmodule
