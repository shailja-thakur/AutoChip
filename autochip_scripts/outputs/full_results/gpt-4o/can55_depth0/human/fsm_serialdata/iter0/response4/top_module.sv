module top_module (
    input clk,
    input in,
    input reset,
    output reg [7:0] out_byte,
    output reg done
);

// State declaration
typedef enum reg [2:0] {
    IDLE,
    START,
    DATA,
    STOP
} state_t;

// State variables
state_t current_state, next_state;
reg [3:0] bit_counter; // Counts bits received
reg [7:0] shift_reg; // Shift register to collect data bits

// Synchronous state transition
always @(posedge clk) begin
    if (reset) begin
        current_state <= IDLE;
        out_byte <= 8'b0;
        done <= 1'b0;
    end
    else begin
        current_state <= next_state;
    end
end

// Synchronous operations
always @(posedge clk) begin
    if (reset) begin
        bit_counter <= 4'b0;
        shift_reg <= 8'b0;
    end
    else begin
        case (current_state)
            START: begin
                bit_counter <= 4'b0;
            end
            DATA: begin
                shift_reg <= {in, shift_reg[7:1]}; // Shift in the received data bit
                bit_counter <= bit_counter + 1;
            end
            STOP: begin
                if (in == 1'b1) begin
                    out_byte <= shift_reg;
                end
            end
        endcase
    end
end

// Next state logic
always @(*) begin
    next_state = current_state;
    done = 1'b0;

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
            if (bit_counter == 4'b1000) begin
                next_state = STOP;
            end
        end
        STOP: begin
            if (in == 1'b1) begin
                done = 1'b1;
                next_state = IDLE;
            end
            else begin
                next_state = IDLE;
            end
        end
    endcase
end

endmodule
