module top_module(
    input wire clk,
    input wire reset,
    output reg data_out,
    output reg valid_out
);
    // State declarations
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    // Internal signals
    reg [1:0] state;
    reg [7:0] counter;

    // Threshold value for transitioning from WAIT to PROCESS
    parameter COUNTER_THRESHOLD = 8'd10;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 8'd0;
            data_out <= 1'b0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 8'd0;
                    data_out <= 1'b0;
                    valid_out <= 1'b0;
                    state <= WAIT;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 1'b0;
                    if (counter >= COUNTER_THRESHOLD) begin
                        state <= PROCESS;
                    end
                end
                PROCESS: begin
                    data_out <= 1'b1;  // Assuming data to process is a simple high signal
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
