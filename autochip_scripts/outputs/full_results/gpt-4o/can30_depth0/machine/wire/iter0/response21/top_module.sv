module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,  // assuming 8-bit data output
    output reg valid_out
    );

    // State definitions
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    
    reg [7:0] counter;
    
    // Initial state
    initial begin
        state = IDLE;
        next_state = IDLE;
        counter = 0;
        data_out = 0;
        valid_out = 0;
    end
    
    // State transitions
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
            data_out <= 0;
            valid_out <= 0;
        end else begin
            state <= next_state;
            if (state == IDLE) begin
                counter <= 0;
            end else if (state == WAIT) begin
                counter <= counter + 1;
            end else if (state == PROCESS) begin
                counter <= 0;
                data_out <= <data_processing_logic>; // Replace with data processing logic
            end else if (state == DONE) begin
                valid_out <= 1;
            end
        end
    end
    
    // Next state logic
    always @* begin
        case (state)
            IDLE: next_state = WAIT;
            WAIT: next_state = (counter == <threshold>) ? PROCESS : WAIT; // Replace <threshold> with the actual threshold value
            PROCESS: next_state = DONE;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

endmodule
