module top_module(
    input wire clock,
    input wire reset,
    output reg [7:0] data_output,
    output reg valid_output
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    reg [3:0] counter; // 4-bit counter for example

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
        next_state = state; // Default to remain in the current state
        data_output = 8'b0; // Default data output
        valid_output = 1'b0;  // Default valid output

        case (state)
            IDLE: begin
                counter = 4'b0;
                if (!reset) begin
                    next_state = WAIT;
                end
            end

            WAIT: begin
                counter = counter + 1;
                if (counter == 4'd10) begin // Threshold example
                    next_state = PROCESS;
                end
            end

            PROCESS: begin
                data_output = 8'b10101010; // Example data processing
                next_state = DONE;
            end

            DONE: begin
                valid_output = 1'b1;
                next_state = IDLE;
            end
        endcase
    end
endmodule
