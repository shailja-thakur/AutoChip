module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State enum for FSM
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    reg [1:0] state, next_state;      // Current and next state variables
    reg [3:0] counter;                // 4-bit counter for counting clock cycles

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0000;
        end else begin
            state <= next_state;
            if (state == WAIT)
                counter <= counter + 4'b0001;
            else
                counter <= 4'b0000;
        end
    end

    // Combinatorial logic for next state and output logic
    always @(*) begin
        next_state = state;
        data_out = 8'b0;
        valid_out = 1'b0;

        case (state)
            IDLE: begin
                if (reset) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT;
                end
            end
            WAIT: begin
                if (counter == 4'b1000) begin  // Threshold value, can be adjusted as needed
                    next_state = PROCESS;
                end else begin
                    next_state = WAIT;
                end
            end
            PROCESS: begin
                data_out = 8'hFF; // Example data, can be assignment as needed
                next_state = DONE;
            end
            DONE: begin
                valid_out = 1'b1;
                next_state = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

endmodule
