module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA = 3'b010,
        STOP = 3'b011,
        WAIT_STOP = 3'b100
    } state_t;

    state_t current_state, next_state;
    reg [7:0] data_reg;
    reg [3:0] bit_counter;

    // State transition
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
            bit_counter <= 0;
            out_byte <= 8'd0;
            done <= 1'b0;
            data_reg <= 8'd0;
        end else begin
            current_state <= next_state;
        end
    end

    // State machine
    always @(*) begin
        next_state = current_state;
        done = 1'b0;

        case (current_state)
            IDLE: begin
                if (!in) // Start bit detected
                    next_state = START;
            end
            START: begin
                next_state = DATA;
                bit_counter = 4'd0;
            end
            DATA: begin
                if (bit_counter == 4'd7) // All 8 data bits received
                    next_state = STOP;
                else
                    next_state = DATA;
            end
            STOP: begin
                if (in) begin // Stop bit detected
                    done = 1'b1;
                    next_state = IDLE;
                end else begin
                    next_state = WAIT_STOP;
                end
            end
            WAIT_STOP: begin
                if (in) begin // Correct stop bit found after erroneous bit
                    done = 1'b1;
                    next_state = IDLE;
                end
            end
        endcase
    end

    // Data path and output logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            data_reg <= 8'd0;
            out_byte <= 8'd0;
        end else begin
            if (current_state == DATA) begin
                data_reg[bit_counter] <= in;
                bit_counter <= bit_counter + 1;
            end
            if (done) begin
                out_byte <= data_reg;
            end
        end
    end

endmodule
