module top_module (
    input clk,
    input reset,
    output reg data_out,
    output reg valid_out
);

    // Define state encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    reg [1:0] state, next_state;
    reg [7:0] counter;
    parameter THRESHOLD = 8'd100; // Example threshold for FSM transition

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // FSM next state logic
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
                if (counter >= THRESHOLD) begin
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

    // Output logic and counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 0;
            valid_out <= 0;
            counter <= 0;
        end else begin
            case (state)
                IDLE: begin
                    data_out <= 0;
                    valid_out <= 0;
                    counter <= 0;
                end

                WAIT: begin
                    data_out <= 0;
                    valid_out <= 0;
                    counter <= counter + 1;
                end

                PROCESS: begin
                    data_out <= 8'hA5; // Example data being processed
                    valid_out <= 0;
                end

                DONE: begin
                    valid_out <= 1;
                end
                
                default: begin
                    data_out <= 0;
                    valid_out <= 0;
                end
            endcase
        end
    end

endmodule
