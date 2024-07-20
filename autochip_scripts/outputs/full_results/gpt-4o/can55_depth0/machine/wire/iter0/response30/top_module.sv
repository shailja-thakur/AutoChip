module top_module(
    input clock,
    input reset,
    output reg data_out,
    output reg valid_out
);

    // State declarations
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [4:0] counter;  // Assuming 5-bit counter for a threshold of 32 (customize as needed)

    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
            data_out <= 0;
            valid_out <= 0;
        end else begin
            state <= next_state;
            if (state == WAIT) counter <= counter + 1;
            else counter <= 0;
        end
    end

    always @(*) begin
        next_state = state;
        case (state)
            IDLE: begin
                data_out = 0;
                valid_out = 0;
                if (!reset)
                    next_state = WAIT;
            end
            WAIT: begin
                data_out = 0;
                valid_out = 0;
                if (counter >= 31)  // Example threshold
                    next_state = PROCESS;
            end
            PROCESS: begin
                data_out = 1;  // Example processed data
                valid_out = 0;
                next_state = DONE;
            end
            DONE: begin
                data_out = 1;
                valid_out = 1;
                next_state = IDLE;
            end
        endcase
    end

endmodule
