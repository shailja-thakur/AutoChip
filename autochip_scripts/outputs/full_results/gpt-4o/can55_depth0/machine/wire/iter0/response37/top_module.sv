module top_module (
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);
    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    // State registers
    state_t state;
    state_t next_state;

    // Counter
    reg [3:0] counter; // Assuming a 4-bit counter, adjust as needed

    // FSM next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (reset)
                    next_state = WAIT;
                else
                    next_state = IDLE;
            end
            WAIT: begin
                if (counter == 4'b1111) // Threshold value for counter
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

    // FSM state update and outputs
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0000;
            data_out <= 8'b00000000;
            valid_out <= 1'b0;
        end else begin
            state <= next_state;

            case (next_state)
                IDLE: begin
                    counter <= 4'b0000;
                    data_out <= 8'b00000000;
                    valid_out <= 1'b0;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'b00000000;
                    valid_out <= 1'b0;
                end
                PROCESS: begin
                    data_out <= 8'b10101010; // Example data, replace with actual data processing
                    valid_out <= 1'b0;
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
            endcase
        end
    end
endmodule
