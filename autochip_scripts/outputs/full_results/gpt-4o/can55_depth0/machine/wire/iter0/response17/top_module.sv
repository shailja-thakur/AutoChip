module top_module (
    input clk,
    input reset,
    output reg data_out,
    output reg valid_out
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
    
    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic and counter
    always @(state or counter) begin
        case (state)
            IDLE: begin
                next_state = WAIT;
                counter = 4'b0000;
                data_out = 1'b0;
                valid_out = 1'b0;
            end
            WAIT: begin
                if (counter < 4'd10) begin // Assuming threshold is 10
                    counter = counter + 1;
                    next_state = WAIT;
                    data_out = 1'b0;
                end else begin
                    next_state = PROCESS;
                end
            end
            PROCESS: begin
                data_out = // Process your data here
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
