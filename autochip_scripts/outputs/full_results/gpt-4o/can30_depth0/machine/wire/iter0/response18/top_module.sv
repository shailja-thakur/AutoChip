module top_module(
    input        clk,
    input        reset,
    output reg   data_out,
    output reg   valid_out
);
    
    // State definitions
    typedef enum logic [1:0] {
        IDLE    = 2'b00,
        WAIT    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;
    
    // Internal signals
    state_t state, next_state;
    reg [31:0] counter;  // Assuming 32-bit counter for simplicity
    reg [31:0] threshold; // Threshold for WAIT state
    
    // Define the reset threshold value here
    initial begin
        threshold = 100;  // Example threshold value
    end
    
    // Sequential block for state transitions and counter
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
            data_out <= 0;
            valid_out <= 0;
        end else begin
            state <= next_state;
            if (state == WAIT) begin
                counter <= counter + 1;
            end else begin
                counter <= 0;
            end
        end
    end
    
    // Combinational block for state decisions
    always @(*) begin
        case (state)
            IDLE: begin
                next_state = WAIT;
                data_out = 0;
                valid_out = 0;
            end
            WAIT: begin
                if (counter >= threshold) begin
                    next_state = PROCESS;
                end else begin
                    next_state = WAIT;
                end
                data_out = 0;
                valid_out = 0;
            end
            PROCESS: begin
                next_state = DONE;
                data_out = /* insert data processing logic here */;
                valid_out = 0;
            end
            DONE: begin
                next_state = IDLE;
                data_out = data_out;
                valid_out = 1;
            end
            default: begin
                next_state = IDLE;
                data_out = 0;
                valid_out = 0;
            end
        endcase
    end
endmodule
