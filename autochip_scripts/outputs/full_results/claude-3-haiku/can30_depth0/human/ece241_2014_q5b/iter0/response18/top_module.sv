module top_module (
    input clk,
    input areset,
    input x,
    output z
);

// One-hot encoding for the states
localparam STATE_A = 2'b01, STATE_B = 2'b10;

// Register to hold the current state
reg [1:0] state_reg, state_next;

// Next state logic
always @(*) begin
    case (state_reg)
        STATE_A: begin
            if (x == 1'b0) begin
                state_next = STATE_A;
            end else begin
                state_next = STATE_B;
            end
        end
        STATE_B: begin
            if (x == 1'b0) begin
                state_next = STATE_B;
            end else begin
                state_next = STATE_B;
            end
        end
        default: begin
            state_next = STATE_A;
        end
    endcase
end

// Output logic
assign z = (state_reg == STATE_B && x == 1'b0) || (state_reg == STATE_A && x == 1'b1);

// State register
always @(posedge clk or posedge areset) begin
    if (areset) begin
        state_reg <= STATE_A;
    end else begin
        state_reg <= state_next;
    end
end

endmodule
