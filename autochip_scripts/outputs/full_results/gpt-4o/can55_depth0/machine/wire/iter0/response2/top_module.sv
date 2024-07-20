module top_module(
    input clk,
    input rst,
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
    reg [3:0] counter;  // Counter to keep track of clock cycles

    // State Machine
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            counter <= 4'b0000;
            data_out <= 8'b00000000;
            valid <= 0;
        end
        else begin
            state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        next_state = state;  // Default state is the current state
        case(state)
            IDLE: begin
                if (rst) begin
                    next_state = IDLE;
                end
                else begin
                    next_state = WAIT;
                    counter = 4'b0000;
                    data_out = 8'b00000000;
                    valid = 0;
                end
            end          
            WAIT: begin
                if (counter < 'd10) begin  // Consider 10 as a threshold
                    next_state = WAIT;
                    counter = counter + 1;
                end
                else begin
                    next_state = PROCESS;
                end
            end  
            PROCESS: begin
                next_state = DONE;
                data_out = 8'b10101010;  // Placeholder processed data
            end
            DONE: begin
                next_state = IDLE;
                valid = 1;
            end
            default: next_state = IDLE;
        endcase
    end
endmodule
