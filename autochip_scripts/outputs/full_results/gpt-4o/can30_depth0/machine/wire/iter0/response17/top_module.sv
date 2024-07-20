module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // Define the states of the FSM
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;
    reg [7:0] counter;
    
    // FSM state transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Counters and output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 8'h00;
            data_out <= 8'h00;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 8'h00;
                    data_out <= 8'h00;
                    valid_out <= 1'b0;
                end
                WAIT: begin
                    counter <= counter + 1'b1;
                    data_out <= 8'h00;
                    valid_out <= 1'b0;
                end
                PROCESS: begin
                    // Process the data (placeholder, replace with actual processing logic)
                    data_out <= 8'hAA;
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
            endcase
        end
    end

    // FSM next state logic
    always_comb begin
        case (state)
            IDLE: begin
                if (reset) 
                    next_state = WAIT;
                else 
                    next_state = IDLE;
            end
            WAIT: begin
                if (counter >= 8'hFF) // Threshold for transition, adjust as needed
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
