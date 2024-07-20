module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// Define the states of the state machine
localparam [1:0] IDLE = 2'b00, CONVERT = 2'b01, DONE = 2'b11;

// State registers
reg [1:0] state, next_state;

// Intermediate signals
reg [7:0] num, negated_num;
reg [3:0] bit_count;

always @(posedge clk, posedge areset) begin
    if (areset) begin
        state <= IDLE;
        num <= 0;
        negated_num <= 0;
        bit_count <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                num <= 0;
                negated_num <= 0;
                bit_count <= 0;
            end
            CONVERT: begin
                num <= {num[6:0], x};
                bit_count <= bit_count + 1;
                if (bit_count == 8) begin
                    negated_num <= ~num + 1;
                    next_state <= DONE;
                end
            end
            DONE: begin
                // Do nothing, wait for reset
            end
        endcase
    end
end

assign z = (state == DONE) ? negated_num[0] : 1'b0;

always @(*) begin
    case (state)
        IDLE: next_state = (areset == 1'b0) ? CONVERT : IDLE;
        CONVERT: next_state = CONVERT;
        DONE: next_state = (areset == 1'b1) ? IDLE : DONE;
        default: next_state = IDLE;
    endcase
end

endmodule
