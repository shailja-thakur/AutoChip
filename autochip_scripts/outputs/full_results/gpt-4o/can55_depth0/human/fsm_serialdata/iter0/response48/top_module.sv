module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

    // State encoding
    typedef enum reg [2:0] {
        IDLE   = 3'b000,
        START  = 3'b001,
        DATA   = 3'b010,
        STOP   = 3'b011,
        WAIT   = 3'b100
    } state_t;
    
    state_t current_state, next_state;
    reg [2:0] bit_counter; // counter for data bits
    reg [7:0] data_shift_reg; // shift register for data byte

    // State Transition
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= IDLE;
        end else begin
            current_state <= next_state;
        end
    end

    // Next State Logic
    always @ * begin
        // Default assignments to retain state and outputs in case of incomplete assignments
        next_state = current_state;
        done = 0;
        
        case (current_state)
            IDLE: begin
                if (in == 0)
                    next_state = START;
                else
                    next_state = IDLE;
            end
            START: begin
                next_state = DATA;
                bit_counter = 0; // Initialize bit counter for data bits
            end
            DATA: begin
                if (bit_counter < 7)
                    next_state = DATA;
                else
                    next_state = STOP;
            end
            STOP: begin
                if (in == 1) begin
                    next_state = IDLE;
                    done = 1;
                end else begin
                    next_state = WAIT;
                end
            end
            WAIT: begin
                if (in == 1)
                    next_state = IDLE;
            end
        endcase
    end

    // Output and Counter Logic
    always @ (posedge clk or posedge reset) begin
        if (reset) begin
            bit_counter <= 0;
            data_shift_reg <= 0;
            done <= 0;
            out_byte <= 0;
        end else begin
            case (current_state)
                IDLE: begin
                    data_shift_reg <= 0;
                    bit_counter <= 0;
                end
                START: begin
                    bit_counter <= 0;
                end
                DATA: begin
                    data_shift_reg[bit_counter] <= in;
                    bit_counter <= bit_counter + 1;
                end
                STOP: begin
                    if (in == 1) begin
                        out_byte <= data_shift_reg;
                        done <= 1;
                    end else begin
                        done <= 0;
                    end
                end
            endcase
        end
    end
endmodule
