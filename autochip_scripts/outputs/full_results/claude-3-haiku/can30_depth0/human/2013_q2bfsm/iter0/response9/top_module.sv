module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

// Define the states of the FSM
parameter STATE_A = 2'b00, STATE_B = 2'b01, STATE_C = 2'b10, STATE_D = 2'b11;
reg [1:0] state, next_state;

// Registers to store the history of x inputs
reg [1:0] x_history;

// Reg to track the number of clock cycles since y became 1
reg [1:0] y_count;

always @(posedge clk, negedge resetn) begin
    if (!resetn) begin
        state <= STATE_A;
        x_history <= 2'b0;
        y_count <= 2'b0;
        f <= 1'b0;
        g <= 1'b0;
    end
    else begin
        state <= next_state;
        x_history <= {x_history[0], x};
        if (y) y_count <= 2'b0;
        else y_count <= y_count + 2'b1;
    end
end

always @(*) begin
    next_state = state;
    case (state)
        STATE_A: begin
            f = 1'b0;
            g = 1'b0;
            if (resetn) next_state = STATE_B;
        end
        STATE_B: begin
            f = 1'b1;
            g = 1'b0;
            next_state = STATE_C;
        end
        STATE_C: begin
            f = 1'b0;
            if (x_history == 2'b101) next_state = STATE_D;
            else next_state = STATE_C;
        end
        STATE_D: begin
            g = 1'b1;
            if (y_count == 2'b10) next_state = STATE_D;
            else next_state = STATE_D;
        end
    endcase
end

endmodule
