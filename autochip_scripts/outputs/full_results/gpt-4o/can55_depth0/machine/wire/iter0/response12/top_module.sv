module top_module (
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid
);

    // State Definition
    typedef enum reg [1:0] {
        IDLE    = 2'b00,
        WAIT    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;

    // State, Counter and Next State Declaration
    state_t state, next_state;
    reg [3:0] counter;
    
    // State Transition Block
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
        end else begin
            state <= next_state;
        end
    end
    
    // Next State Logic and Output Logic
    always @(*) begin
        // Default Values
        next_state = state;
        data_out = 8'b0;
        valid = 1'b0;
        
        case (state)
            IDLE: begin
                counter = 0;
                data_out = 8'b0;
                if (!reset) begin
                    next_state = WAIT;
                end
            end
            
            WAIT: begin
                counter = counter + 1;
                if (counter == 4'd10) begin // Assuming threshold for transition is 10 clock cycles
                    next_state = PROCESS;
                end
            end

            PROCESS: begin
                data_out = 8'hFF; // Data to be processed and output
                next_state = DONE;
            end

            DONE: begin
                valid = 1'b1;
                next_state = IDLE;
            end
            
            default: next_state = IDLE;
        endcase
    end

endmodule
