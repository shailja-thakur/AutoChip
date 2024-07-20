module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);
    
    // Define the state encoding
    typedef enum logic [1:0] {
        IDLE    = 2'b00,
        WAIT    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;

    // Declare state register and next state logic
    state_t state, next_state;

    // Internal signals
    reg [3:0] counter;
    
    // State transition and output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
            data_out <= 8'b00000000;
            valid_out <= 1'b0;
        end else begin
            state <= next_state;
            case (state)
                IDLE: begin
                    counter <= 0;
                    data_out <= 8'b00000000;
                    valid_out <= 1'b0;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'b00000000;
                    valid_out <= 1'b0;
                end
                PROCESS: begin
                    data_out <= 8'b10101010; // Example processed data
                    valid_out <= 1'b0;
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
            endcase
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            IDLE: begin
                if (reset) 
                    next_state = IDLE;
                else
                    next_state = WAIT;
            end
            WAIT: begin
                if (counter == 4'b1111) // Example threshold value
                    next_state = PROCESS;
                else
                    next_state = WAIT;
            end
            PROCESS: begin
                next_state = DONE;
            end
            DONE: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
