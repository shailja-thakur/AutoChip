module top_module(
    input clk,       // Clock input
    input reset,     // Reset input
    output reg [7:0] data_out, // Data output
    output reg valid_out    // Valid output
);

    // State declaration
    typedef enum logic [1:0] {
        IDLE    = 2'b00,
        WAIT    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;

    state_t state, next_state;  // Current and next state variables
    reg [7:0] counter;          // 8-bit counter

    // Sequential logic for state transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'b0;
        end
        else begin
            state <= next_state;
            if (state == WAIT) 
                counter <= counter + 1;
            else 
                counter <= 8'b0;
        end
    end

    // Combinational logic for next state and output
    always @(*) begin
        // Default assignments
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
                if (counter == 8'hFF) begin  // Threshold for counter
                    next_state = PROCESS;
                end
            end
            PROCESS: begin
                data_out = 8'hAA;  // Example processed data
                next_state = DONE;
            end
            DONE: begin
                valid_out = 1'b1;
                next_state = IDLE;
            end
        endcase
    end
endmodule
