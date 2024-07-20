module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // FSM states
    typedef enum reg [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;

    // Internal signals
    reg [3:0] counter;

    // Next state logic
    always @(*) begin
        case (state)
            IDLE: next_state = (reset) ? IDLE : WAIT;
            WAIT: next_state = (counter == 4'd10) ? PROCESS : WAIT;
            PROCESS: next_state = DONE;
            DONE: next_state = IDLE;
            default: next_state = IDLE;
        endcase
    end

    // Output logic and state transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'd0;
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else begin
            state <= next_state;
            if (state == WAIT) begin
                counter <= counter + 1;
                data_out <= 8'd0;
            end else if (state == PROCESS) begin
                data_out <= 8'd255; // Example processed data
            end else if (state == DONE) begin
                valid_out <= 1'b1;
            end else begin
                counter <= 4'd0;
                data_out <= 8'd0;
                valid_out <= 1'b0;
            end
        end
    end
endmodule
