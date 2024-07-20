module top_module(
    input wire clock,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE    = 2'b00,
        WAIT    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;

    // Internal signals
    reg [1:0] state, next_state;
    reg [15:0] counter;

    // FSM state transition
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = WAIT;
                end else begin
                    next_state = IDLE;
                end
            end

            WAIT: begin
                if (counter == 16'hFFFF) begin
                    next_state = PROCESS;
                end else begin
                    next_state = WAIT;
                end
            end

            PROCESS: begin
                next_state = DONE;
            end

            DONE: begin
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

    // Output logic
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            counter <= 16'b0;
            data_out <= 8'b0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 16'b0;
                    data_out <= 8'b0;
                    valid_out <= 1'b0;
                end

                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'b0;
                    valid_out <= 1'b0;
                end

                PROCESS: begin
                    data_out <= 8'hAA; // Example data processing
                    valid_out <= 1'b0;
                end

                DONE: begin
                    valid_out <= 1'b1;
                end
            endcase
        end
    end

endmodule
