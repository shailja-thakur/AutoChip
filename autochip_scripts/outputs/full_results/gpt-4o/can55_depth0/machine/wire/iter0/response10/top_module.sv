module top_module(
    input clock,
    input reset,
    output reg [7:0] data_out,
    output reg valid
);

    typedef enum reg [1:0] {IDLE, WAIT, PROCESS, DONE} state_t;
    state_t state, next_state;
    reg [7:0] counter;

    // State transition logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always @(*) begin
        case (state)
            IDLE: begin
                next_state = WAIT;
                counter = 0;
                data_out = 0;
                valid = 0;
            end
            WAIT: begin
                if (counter < 8'hFF) begin
                    next_state = WAIT;
                    counter = counter + 1;
                    data_out = 0;
                    valid = 0;
                end else begin
                    next_state = PROCESS;
                end
            end
            PROCESS: begin
                next_state = DONE;
                data_out = 8'hA5; // Example data to output
                valid = 0;
            end
            DONE: begin
                next_state = IDLE;
                valid = 1;
            end
            default: begin
                next_state = IDLE;
                data_out = 0;
                valid = 0;
            end
        endcase
    end

    // Counter logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            counter <= 0;
        end else if (state == WAIT) begin
            counter <= counter + 1;
        end else begin
            counter <= 0;
        end
    end

endmodule
