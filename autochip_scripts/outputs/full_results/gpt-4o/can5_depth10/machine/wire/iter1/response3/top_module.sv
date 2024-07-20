module top_module(
    input clock,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State encoding
    typedef enum reg [1:0] {IDLE, WAIT, PROCESS, DONE} state_t;
    state_t state, next_state;

    // Internal signals
    reg [7:0] counter;

    // State transition logic
    always @ (posedge clock or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'd0;
        end else begin
            state <= next_state;

            if (state == WAIT)
                counter <= counter + 1;
            else if (state == IDLE)
                counter <= 8'd0;
        end
    end

    // Next state logic
    always @ (*) begin
        case (state)
            IDLE: next_state = WAIT;
            WAIT: next_state = (counter == 8'd10) ? PROCESS : WAIT;
            PROCESS: next_state = DONE;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic
    always @ (*) begin
        case (state)
            IDLE: begin
                data_out = 8'd0;
                valid_out = 1'b0;
            end
            WAIT: begin
                data_out = 8'd0;
                valid_out = 1'b0;
            end
            PROCESS: begin
                data_out = counter; // or any other data processing logic
                valid_out = 1'b0;
            end
            DONE: begin
                valid_out = 1'b1;
            end
            default: begin
                data_out = 8'd0;
                valid_out = 1'b0;
            end
        endcase
    end

endmodule
