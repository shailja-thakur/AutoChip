module top_module(
    input wire clk,
    input wire reset,
    output reg [7:0] data_out,
    output reg valid_out
);

    // State encoding
    typedef enum reg [1:0] {
        idle = 2'b00,
        wait = 2'b01,
        process = 2'b10,
        done = 2'b11
    } state_t;

    // Internal signals
    state_t state, next_state;
    reg [3:0] counter;  // Assuming a 4-bit counter for demonstration purposes

    initial begin
        state = idle;
        next_state = idle;
        data_out = 8'b0;
        valid_out = 1'b0;
    end

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= idle;
            counter <= 4'b0;
            data_out <= 8'b0;
        end else begin
            state <= next_state;
            if (state == wait) begin
                counter <= counter + 1;
            end else if (state == process || state == idle) begin
                counter <= 4'b0;
            end
        end
    end

    // Next state logic and output logic
    always @(*) begin
        next_state = state;
        valid_out = 1'b0;
        case (state)
            idle: begin
                if (reset) begin
                    next_state = idle;
                    data_out = 8'b0;
                end else begin
                    next_state = wait;
                end
            end
            wait: begin
                if (counter < 4'b1111) begin  // Threshold value for counter
                    next_state = wait;
                    data_out = 8'b0;
                end else begin
                    next_state = process;
                end
            end
            process: begin
                data_out = 8'hAA;  // Arbitrary example data for processing
                next_state = done;
            end
            done: begin
                valid_out = 1'b1;
                next_state = idle;
            end
            default: begin
                next_state = idle;
            end
        endcase
    end

endmodule
