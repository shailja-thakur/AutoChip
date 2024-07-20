module top_module (
	input clk,
	input in,
	input reset,
	output reg done
);

typedef enum logic [2:0] {
    IDLE        = 3'b000,
    START_BIT   = 3'b001,
    DATA_BITS   = 3'b010,
    STOP_BIT    = 3'b011,
    ERROR_STATE = 3'b100
} state_t;

state_t current_state, next_state;

reg [2:0] bit_counter;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= IDLE;
        bit_counter <= 3'd0;
    end else begin
        current_state <= next_state;
    end
end

always @(*) begin
    next_state = current_state;
    done = 1'b0;
    case (current_state)
        IDLE: begin
            if (in == 1'b0) begin
                next_state = START_BIT;
            end
        end
        START_BIT: begin
            next_state = DATA_BITS;
        end
        DATA_BITS: begin
            if (bit_counter == 3'd7) begin
                next_state = STOP_BIT;
            end else begin
                bit_counter = bit_counter + 1;
                next_state = DATA_BITS;
            end
        end
        STOP_BIT: begin
            if (in == 1'b1) begin
                done = 1'b1;
                next_state = IDLE;
            end else begin
                next_state = ERROR_STATE;
            end
        end
        ERROR_STATE: begin
            if (in == 1'b1) begin
                next_state = IDLE;
            end
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

always @(posedge clk or posedge reset) begin
    if (reset) begin
        bit_counter <= 3'd0;
    end else if (current_state == DATA_BITS) begin
        bit_counter <= bit_counter + 1;
    end else begin
        bit_counter <= 3'd0;
    end
end

endmodule
