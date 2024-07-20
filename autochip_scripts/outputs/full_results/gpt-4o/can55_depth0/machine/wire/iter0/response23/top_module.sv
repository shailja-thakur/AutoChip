module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State Definitions
    typedef enum reg [1:0] {
        IDLE    = 2'b00,
        WAIT    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;

    // Internal Signals
    reg [1:0] state;
    reg [3:0] counter; // Example 4-bit counter

    // State Machine Logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0;
            data_out <= 8'b0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 4'b0;
                    data_out <= 8'b0;
                    state <= WAIT;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 8'b0;
                    if (counter == 4'b1111) // Threshold example
                        state <= PROCESS;
                end
                PROCESS: begin
                    data_out <= 8'b10101010; // Example data processing
                    state <= DONE;
                end
                DONE: begin
                    valid_out <= 1'b1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
