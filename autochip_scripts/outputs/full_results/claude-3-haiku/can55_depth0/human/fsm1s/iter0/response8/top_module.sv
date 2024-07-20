module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

// Define the states
localparam STATE_A = 1'b0;
localparam STATE_B = 1'b1;

// Register to store the current state
reg state_reg, state_next;

// Combinational logic for next state
always @(*) begin
    case (state_reg)
        STATE_A: begin
            if (in == 1'b0) begin
                state_next = STATE_B;
            end else begin
                state_next = STATE_A;
            end
        end
        STATE_B: begin
            if (in == 1'b0) begin
                state_next = STATE_B;
            end else begin
                state_next = STATE_A;
            end
        end
        default: begin
            state_next = STATE_B;
        end
    endcase
end

// Combinational logic for output
always @(*) begin
    if (state_reg == STATE_B) begin
        out = 1'b1;
    end else begin
        out = 1'b0;
    end
end

// Sequential logic for state update
always @(posedge clk) begin
    if (reset == 1'b1) begin
        state_reg <= STATE_B;
    end else begin
        state_reg <= state_next;
    end
end

endmodule
