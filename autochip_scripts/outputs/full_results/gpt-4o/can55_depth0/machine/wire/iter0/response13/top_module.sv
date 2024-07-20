module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);
    
    // State encoding
    typedef enum logic [1:0] {
        IDLE    = 2'b00,
        WAIT    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;

    // Internal signals
    state_t state, next_state;
    reg [3:0] counter;  // Assumed width; adjust as necessary

    // State transition logic
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0000;
            data_out <= 8'b00000000;
            valid_out <= 1'b0;
        end else begin
            state <= next_state;
            
            case (state)
                IDLE: begin
                    counter <= 4'b0000;
                    data_out <= 8'b00000000;
                    valid_out <= 1'b0;
                end 
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'b00000000;
                    valid_out <= 1'b0;
                end
                PROCESS: begin
                    data_out <= // Your data processing logic here
                    valid_out <= 1'b0;
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
                default: begin
                    counter <= 4'b0000;
                    data_out <= 8'b00000000;
                    valid_out <= 1'b0;
                end
            endcase
        end
    end

    // Next state logic
    always @(*) begin
        case(state)
            IDLE: begin
                if (!reset)
                    next_state = WAIT;
                else
                    next_state = IDLE;
            end
            WAIT: begin
                if (counter == 4'b1111) // Assuming threshold is 15; adjust as needed
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
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
