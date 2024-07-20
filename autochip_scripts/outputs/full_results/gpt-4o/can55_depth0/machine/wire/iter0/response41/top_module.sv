module top_module (
    input wire clk,
    input wire reset,
    output reg data_out,
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
    reg [3:0] counter; // 4-bit counter for example threshold

    // Synchronous state and counter update
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0000;
        end else begin
            state <= next_state;
            if (state == WAIT)
                counter <= counter + 1;
            else
                counter <= 4'b0000;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                next_state = WAIT;
            end
            WAIT: begin
                if (counter == 4'b1111) // threshold example
                    next_state = PROCESS;
                else
                    next_state = WAIT;
            end
            PROCESS: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // Output and data processing logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 1'b0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    data_out <= 1'b0;
                    valid_out <= 1'b0;
                end
                WAIT: begin
                    data_out <= 1'b0;
                    valid_out <= 1'b0;
                end
                PROCESS: begin
                    data_out <= 1'b1; // Example data, replace with actual data processing
                    valid_out <= 1'b0;
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
            endcase
        end
    end

endmodule
