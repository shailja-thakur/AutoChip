module top_module (
    input clock,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State declaration
    typedef enum reg [1:0] {
        idle = 2'b00,
        wait = 2'b01,
        process = 2'b10,
        done = 2'b11
    } state_t;

    // Internal signals
    state_t state, next_state;
    reg [3:0] counter;

    // State transition
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            state <= idle;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic and outputs
    always @(*) begin
        // Default values
        next_state = state;
        data_out = 8'b0;
        valid_out = 1'b0;

        case (state)
            idle: begin
                counter = 4'b0;
                data_out = 8'b0;
                if (!reset) 
                    next_state = wait;
            end
            
            wait: begin
                counter = counter + 1;
                data_out = 8'b0;
                if (counter == 4'b1111) 
                    next_state = process;
            end
            
            process: begin
                data_out = 8'hA5; // Example data being processed
                next_state = done;
            end

            done: begin
                valid_out = 1'b1;
                next_state = idle;
            end
        endcase
    end
endmodule
