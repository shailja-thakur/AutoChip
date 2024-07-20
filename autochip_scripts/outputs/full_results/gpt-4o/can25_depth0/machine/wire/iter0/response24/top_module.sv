module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;
    state_t state, next_state;

    // Internal signals
    reg [3:0] counter;

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0000;
            data_out <= 8'b00000000;
            valid <= 0;
        end else begin
            state <= next_state;
            case (next_state)
                IDLE: begin
                    counter <= 4'b0000;
                    data_out <= 8'b00000000;
                    valid <= 0;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'b00000000;
                    valid <= 0;
                end
                PROCESS: begin
                    data_out <= counter;  // Example processing logic
                    valid <= 0;
                end
                DONE: begin
                    valid <= 1;
                end
            endcase
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: next_state = WAIT;
            WAIT: next_state = (counter == 4'b1111) ? PROCESS : WAIT;
            PROCESS: next_state = DONE;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

endmodule
