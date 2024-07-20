module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State definitions
    typedef enum reg [1:0] {
        IDLE     = 2'b00,
        WAIT     = 2'b01,
        PROCESS  = 2'b10,
        DONE     = 2'b11
    } state_t;

    state_t state, next_state;
    reg [3:0] counter;

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (reset) 
                    next_state = IDLE;
                else 
                    next_state = WAIT;
            end
            
            WAIT: begin
                if (counter == 4'b1001) 
                    next_state = PROCESS;
                else 
                    next_state = WAIT;
            end
            
            PROCESS: 
                next_state = DONE;
                
            DONE: 
                next_state = IDLE;
            
            default: 
                next_state = IDLE;
        endcase
    end

    // State and counter update logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
        end else begin
            state <= next_state;
            if (state == WAIT)
                counter <= counter + 1;
            else
                counter <= 0;
        end
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 0;
            valid_out <= 0;
        end else begin
            case (state)
                IDLE: begin
                    data_out <= 0;
                    valid_out <= 0;
                end
                
                WAIT: begin
                    data_out <= 0;
                    valid_out <= 0;
                end
                
                PROCESS:
                    data_out <= 8'b10101010; // Example processed data
                
                DONE:
                    valid_out <= 1;
                
                default: begin
                    data_out <= 0;
                    valid_out <= 0;
                end
            endcase
        end
    end
endmodule
