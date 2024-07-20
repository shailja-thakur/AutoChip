module top_module (
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // FSM states
    typedef enum logic [1:0] {
        IDLE    = 2'b00,
        WAIT    = 2'b01,
        PROCESS = 2'b10,
        DONE    = 2'b11
    } state_t;

    state_t state, next_state;

    // Counter to track clock cycles
    reg [3:0] counter;

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
            counter <= 4'b0;
            data_out <= 8'b0;
            valid_out <= 1'b0;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_ff @(posedge clk) begin
        case (state)
            IDLE: begin
                counter <= 4'b0;
                data_out <= 8'b0;
                valid_out <= 1'b0;
                if (!reset) begin
                    next_state <= WAIT;
                end else begin
                    next_state <= IDLE;
                end
            end
            WAIT: begin
                counter <= counter + 1;
                data_out <= 8'b0;
                if (counter == 4'b1111) begin
                    next_state <= PROCESS;
                end else begin
                    next_state <= WAIT;
                end
            end
            PROCESS: begin
                data_out <= 8'hFF;  // Example data, replace with actual data processing
                next_state <= DONE;
            end
            DONE: begin
                valid_out <= 1'b1;
                next_state <= IDLE;
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
endmodule
