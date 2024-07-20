module top_module(
    input wire clk,
    input wire rst,
    output reg [7:0] data_out,
    output reg valid_out
);

    // Define states
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;

    // Internal signals
    reg [7:0] counter;
    reg [7:0] internal_data;

    // State transition logic
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    // State machine next state and output logic
    always @(*) begin
        // Default assignments
        next_state = state;
        valid_out = 0;
        case (state)
            IDLE: begin
                data_out = 8'b0;
                if (rst) begin
                    counter = 0;
                    next_state = WAIT;
                end
                else
                    next_state = IDLE;
            end
            
            WAIT: begin
                data_out = 8'b0;
                counter = counter + 1;
                if (counter == 8'b11111111)
                    next_state = PROCESS;
                else
                    next_state = WAIT;
            end
            
            PROCESS: begin
                internal_data = 8'b10101010; // Example processed data
                data_out = internal_data;
                next_state = DONE;
            end
            
            DONE: begin
                valid_out = 1;
                next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end
endmodule
