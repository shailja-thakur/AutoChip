module top_module(
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
    reg [3:0] counter; // 4-bit counter for illustration purposes

    // State transition logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= IDLE;
        end else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        case (state)
            IDLE: begin
                // Logic for idle state
                if (!reset) begin
                    next_state = WAIT;
                end
            end
            WAIT: begin
                // Logic for wait state
                if (counter == 4'd10) begin // Assume the threshold is 10 clock cycles
                    next_state = PROCESS;
                end
            end
            PROCESS: begin
                // Logic for process state
                next_state = DONE;
            end
            DONE: begin
                // Logic for done state
                next_state = IDLE;
            end
        endcase
    end

    // Counter logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            counter <= 4'd0;
        end else if (state == WAIT) begin
            counter <= counter + 1;
        end else begin
            counter <= 4'd0;
        end
    end

    // Output logic
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            data_out <= 8'd0;
            valid_out <= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                end
                WAIT: begin
                    data_out <= 8'd0;
                    valid_out <= 1'b0;
                end
                PROCESS: begin
                    data_out <= 8'd255; // Example data
                    valid_out <= 1'b0;
                end
                DONE: begin
                    valid_out <= 1'b1;
                end
            endcase
        end
    end
endmodule
