module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);
    
    // State declaration
    typedef enum reg [1:0] {
        IDLE    = 2'b00,
        WAIT    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;

    state_t state, next_state;

    // Internal Signals
    reg [7:0] counter;

    // State transition and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'b0;
            data_out <= 8'b0;
            valid_out <= 0;
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    counter <= 8'b0;
                    data_out <= 8'b0;
                    valid_out <= 0;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'b0;
                end
                PROCESS: begin
                    data_out <= 8'ha5; // Example processed data
                end
                DONE: begin
                    valid_out <= 1;
                end
            endcase
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (!reset)
                    next_state = WAIT;
                else
                    next_state = IDLE;
            end
            WAIT: begin
                if (counter == 8'd10) // Threshold value
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
endmodule
