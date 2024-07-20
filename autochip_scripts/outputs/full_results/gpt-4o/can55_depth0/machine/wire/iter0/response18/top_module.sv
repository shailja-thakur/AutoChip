module top_module (
    input wire clock,
    input wire reset,
    output reg [7:0] data_out,  // Assuming 8-bit data output for illustration
    output reg valid_out
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE    = 2'b00,
        WAIT    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;

    // Internal signals
    reg [1:0] state;
    reg [7:0] counter;
    reg [7:0] data;

    // Threshold value for counter to transition from WAIT to PROCESS
    localparam THRESHOLD = 8'd100;  // Example threshold value

    // State Transition and Data Processing
    always @(posedge clock or posedge reset) begin
        if (reset) begin
            // Reset state
            state <= IDLE;
            counter <= 0;
            data_out <= 0;
            valid_out <= 0;
        end else begin
            case (state)
                IDLE: begin
                    // Perform IDLE state actions
                    counter <= 0;
                    data_out <= 0;
                    valid_out <= 0;
                    state <= WAIT;
                end
                WAIT: begin
                    // Perform WAIT state actions
                    counter <= counter + 1;
                    data_out <= 0;
                    valid_out <= 0;
                    if (counter >= THRESHOLD) begin
                        state <= PROCESS;
                    end
                end
                PROCESS: begin
                    // Perform PROCESS state actions
                    data_out <= data;  // Assuming 'data' holds the value to output
                    state <= DONE;
                end
                DONE: begin
                    // Perform DONE state actions
                    valid_out <= 1;
                    state <= IDLE;
                end
                default: begin
                    // Default state actions in case of an unknown state
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule
