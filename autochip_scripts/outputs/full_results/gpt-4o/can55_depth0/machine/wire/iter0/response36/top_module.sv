module top_module (
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State encoding
    typedef enum logic [1:0] {
        IDLE = 2'b00,
        WAIT = 2'b01,
        PROCESS = 2'b10,
        DONE = 2'b11
    } state_t;

    state_t state, next_state;

    // Internal signals
    reg [7:0] counter;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // State transition and output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 0;
            data_out <= 0;
            valid_out <= 0;
        end else begin
            case (state)
                IDLE: begin
                    counter <= 0;
                    data_out <= 0;
                    valid_out <= 0;
                    next_state <= WAIT;
                end
                WAIT: begin
                    counter <= counter + 1;
                    data_out <= 0;
                    valid_out <= 0;
                    if (counter == 8'hFF) begin
                        next_state <= PROCESS;
                    end else begin
                        next_state <= WAIT;
                    end
                end
                PROCESS: begin
                    data_out <= counter;  // Example data processing
                    valid_out <= 0;
                    next_state <= DONE;
                end
                DONE: begin
                    valid_out <= 1;  // Data output is now valid
                    next_state <= IDLE;
                end
                default: begin
                    next_state <= IDLE;
                end
            endcase
        end
    end

endmodule
