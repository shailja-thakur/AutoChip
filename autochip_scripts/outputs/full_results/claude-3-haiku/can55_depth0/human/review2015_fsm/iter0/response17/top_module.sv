module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

// Define the states
localparam [2:0] 
    WAIT_START = 3'd0,
    SHIFT_BITS = 3'd1,
    COUNTING   = 3'd2,
    WAIT_ACK   = 3'd3;

reg [2:0] state, next_state;
reg [3:0] shift_reg;

// State register
always @(posedge clk, posedge reset) begin
    if (reset)
        state <= WAIT_START;
    else
        state <= next_state;
end

// Next state logic
always @(*) begin
    next_state = state;
    case (state)
        WAIT_START: begin
            if (shift_reg == 4'b1101)
                next_state = SHIFT_BITS;
            else
                next_state = WAIT_START;
        end
        SHIFT_BITS: begin
            if (shift_ena == 1'b1 && shift_reg[3:0] == 4'b0000)
                next_state = COUNTING;
            else
                next_state = SHIFT_BITS;
        end
        COUNTING: begin
            if (done_counting)
                next_state = WAIT_ACK;
            else
                next_state = COUNTING;
        end
        WAIT_ACK: begin
            if (ack)
                next_state = WAIT_START;
            else
                next_state = WAIT_ACK;
        end
    endcase
end

// Output logic
always @(*) begin
    shift_ena = 1'b0;
    counting = 1'b0;
    done = 1'b0;
    case (state)
        WAIT_START: begin
            // Shift in new data bit
            shift_reg <= {shift_reg[2:0], data};
        end
        SHIFT_BITS: begin
            // Enable shifting for 4 clock cycles
            shift_ena = 1'b1;
        end
        COUNTING: begin
            // Indicate counting in progress
            counting = 1'b1;
        end
        WAIT_ACK: begin
            // Notify user and wait for acknowledgement
            done = 1'b1;
        end
    endcase
end

endmodule
