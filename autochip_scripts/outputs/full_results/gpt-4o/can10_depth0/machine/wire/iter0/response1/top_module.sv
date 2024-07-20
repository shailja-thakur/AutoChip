module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // Define parameters for states
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    // Internal signals
    reg [1:0] state, next_state;
    reg [7:0] counter;

    // FSM state transitions
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'b0;
        end
        else begin
            state <= next_state;
            if (state == IDLE || state == WAIT) begin
                counter <= counter + 1;
            end
        end
    end

    // Next state logic
    always @ (*) begin
        case (state)
            IDLE: begin
                data_out = 8'b0;
                valid_out = 1'b0;
                if (reset)
                    next_state = IDLE;
                else
                    next_state = WAIT;
            end

            WAIT: begin
                data_out = 8'b0;
                valid_out = 1'b0;
                // Define a threshold value, here using 8 for the example
                if (counter == 8'd8)
                    next_state = PROCESS;
                else
                    next_state = WAIT;
            end

            PROCESS: begin
                data_out = 8'd255; // Example data, should be replaced by actual processing logic
                valid_out = 1'b0;
                next_state = DONE;
            end

            DONE: begin
                data_out = 8'd255; // Example data, should be replaced by actual logic
                valid_out = 1'b1;
                next_state = IDLE;
            end

            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
