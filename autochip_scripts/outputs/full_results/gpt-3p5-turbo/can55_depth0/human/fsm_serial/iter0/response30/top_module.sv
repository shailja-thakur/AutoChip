module top_module (
    input clk,
    input in,
    input reset,
    output done
);

// State definition
typedef enum logic [2:0] {
    IDLE,
    START_BIT,
    DATA_BITS,
    STOP_BIT
} state_t;

// Registers
reg [2:0] state_reg, state_next;
reg [7:0] data_reg;
reg done_reg;

// State machine
always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
        state_reg <= IDLE;
        data_reg <= 8'd0;
        done_reg <= 1'b0;
    end else begin
        state_reg <= state_next;
        if (state_next == DATA_BITS) begin
            data_reg <= {in, data_reg[7:1]};
        end
        done_reg <= (state_next == STOP_BIT && in);
    end
end

// Next state logic
always_comb begin
    state_next = state_reg;
    case (state_reg)
        IDLE:
            if (in == 1'b0)
                state_next = START_BIT;
        START_BIT:
            if (in == 1'b1)
                state_next = DATA_BITS;
        DATA_BITS:
            if (data_reg[0] == 1'b1)
                state_next = STOP_BIT;
        STOP_BIT:
            if (in == 1'b1)
                state_next = IDLE;
    endcase
end

assign done = done_reg;

endmodule
