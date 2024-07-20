module top_module (
    input clk,
    input in,
    input reset,
    output reg done
);

    // State encoding
    typedef enum logic [2:0] {
        IDLE = 3'b000,
        START = 3'b001,
        DATA0 = 3'b010,
        DATA1 = 3'b011,
        DATA2 = 3'b100,
        DATA3 = 3'b101,
        DATA4 = 3'b110,
        DATA5 = 3'b111,
        DATA6 = 3'b000,
        DATA7 = 3'b001,
        STOP  = 3'b010
    } state_t;

    state_t state, next_state;
    reg [2:0] data_count;

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset)
            state <= IDLE;
        else
            state <= next_state;
    end

    // Next state logic
    always_comb begin
        next_state = state;
        done = 1'b0;
        case (state)
            IDLE: begin
                if (in == 1'b0) // Detect start bit
                    next_state = START;
            end
            START: begin
                next_state = DATA0;
            end
            DATA0: next_state = DATA1;
            DATA1: next_state = DATA2;
            DATA2: next_state = DATA3;
            DATA3: next_state = DATA4;
            DATA4: next_state = DATA5;
            DATA5: next_state = DATA6;
            DATA6: next_state = DATA7;
            DATA7: next_state = STOP;
            STOP: begin
                if (in == 1'b1) begin // Detect stop bit
                    done = 1'b1;
                    next_state = IDLE;
                end
                else begin // Error, wait for a correct stop bit
                    next_state = STOP;
                end
            end
        endcase
    end

endmodule
