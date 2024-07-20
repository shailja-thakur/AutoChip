module top_module(
    input clk,
    input reset,
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

    state_t state, next_state;
    reg [3:0] counter;  // Counter to keep track of clock cycles

    // FSM State Transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0;
            data_out <= 8'b0;
            valid_out <= 1'b0;
        end else begin
            state <= next_state;
            if (state == WAIT) begin
                counter <= counter + 1;
            end else if (state == IDLE) begin
                counter <= 4'b0;
            end
        end
    end

    // FSM Next State Logic
    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                if (reset) begin
                    data_out = 8'b0;
                    counter = 4'b0;
                    next_state = WAIT;
                end
            end
            WAIT: begin
                data_out = 8'b0;
                if (counter >= 4'b1111) begin
                    next_state = PROCESS;
                end
            end
            PROCESS: begin
                data_out = 8'hAB; // Example processed data
                next_state = DONE;
            end
            DONE: begin
                valid_out = 1'b1;
                next_state = IDLE;
            end
            default: next_state = IDLE;
        endcase
    end

    // FSM Output Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            valid_out <= 1'b0;
            data_out <= 8'b0;
        end else begin
            case (state)
                IDLE: begin
                    valid_out <= 1'b0;
                    data_out <= 8'b0;
                end
                WAIT: begin
                    valid_out <= 1'b0;
                end
                PROCESS: begin
                    valid_out <= 1'b0;
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
                default: begin
                    valid_out <= 1'b0;
                    data_out <= 8'b0;
                end
            endcase
        end
    end

endmodule
