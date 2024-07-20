module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,  // Assuming 8-bit data output
    output reg valid_out
);

    // Internal signals
    reg [1:0] state, next_state;
    reg [3:0] counter;  // Assuming a 4-bit counter for the example

    // Define states
    localparam IDLE = 2'b00, 
               WAIT = 2'b01,
               PROCESS = 2'b10,
               DONE = 2'b11;

    // Next State Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0;
        end else begin
            state <= next_state;
            if (state == WAIT)
                counter <= counter + 1;
            else if (state == IDLE)
                counter <= 4'b0;
        end
    end

    // State Transitions and Output Logic
    always @(*) begin
        // Default values
        next_state = state;
        data_out = 8'b0;
        valid_out = 0;

        case (state)
            IDLE: begin
                if (!reset) begin
                    next_state = WAIT;
                end
            end
            WAIT: begin
                if (counter == 4'd10) begin  // Assuming threshold is 10 cycles
                    next_state = PROCESS;
                end else begin
                    next_state = WAIT;
                end
            end
            PROCESS: begin
                data_out = 8'b10101010;  // Example data to be processed
                next_state = DONE;
            end
            DONE: begin
                valid_out = 1;
                next_state = IDLE;
            end
        endcase
    end
endmodule
