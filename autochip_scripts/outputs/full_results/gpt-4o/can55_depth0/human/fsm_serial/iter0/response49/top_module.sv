module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE,
        START,
        DATA,
        STOP,
        WAIT_STOP
    } state_t;

    state_t current_state, next_state;
    reg [2:0] bit_counter;
    reg [7:0] data_buffer;

    // State transition logic
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 3'd0;
            data_buffer <= 8'd0;
            done <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == DATA) begin
                bit_counter <= bit_counter + 1;
                data_buffer <= {in, data_buffer[7:1]};
            end else begin
                bit_counter <= 3'd0;
            end

            if (current_state == STOP && in == 1'b1) begin
                done <= 1'b1;
            end else begin
                done <= 1'b0;
            end
        end
    end

    // Next state logic
    always @* begin
        next_state = current_state; // Default to stay in the current state
        case (current_state)
            IDLE: begin
                if (in == 1'b0) begin
                    next_state = START;
                end
            end

            START: begin
                next_state = DATA;
            end

            DATA: begin
                if (bit_counter == 3'd7) begin
                    next_state = STOP;
                end
            end
                
            STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_STOP;
                end
            end

            WAIT_STOP: begin
                if (in == 1'b1) begin
                    next_state = IDLE;
                end
            end
        endcase
    end

endmodule
