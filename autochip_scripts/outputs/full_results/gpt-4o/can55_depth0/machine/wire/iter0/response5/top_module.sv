module top_module(
    input clk,
    input reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State encoding
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    reg [1:0] state, next_state;
    reg [3:0] counter;

    // State transition on clock edge
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 0;
            data_out <= 8'b0;
            valid_out <= 0;
        end else begin
            state <= next_state;
            if (state == WAIT) counter <= counter + 1;
            else counter <= 0;

            if (state == PROCESS) data_out <= 8'hAB; // Example processed data
            else data_out <= 8'b0;

            if (state == DONE) valid_out <= 1;
            else valid_out <= 0;
        end
    end

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: next_state = WAIT;
            WAIT: next_state = (counter < 4'd10) ? WAIT : PROCESS;
            PROCESS: next_state = DONE;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end
endmodule
