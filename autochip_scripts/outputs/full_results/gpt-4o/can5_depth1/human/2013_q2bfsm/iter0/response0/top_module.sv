module top_module (
    input clk,
    input resetn,
    input x,
    input y,
    output reg f,
    output reg g
);

typedef enum reg [2:0] {
    STATE_A = 3'b000,
    STATE_B = 3'b001,
    STATE_C = 3'b010,
    STATE_D = 3'b011,
    STATE_E = 3'b100,
    STATE_F = 3'b101
} state_t;

state_t current_state, next_state;
reg [1:0] y_counter;

always @(posedge clk or negedge resetn) begin
    if (!resetn)
        current_state <= STATE_A;
    else
        current_state <= next_state;
end

always @(posedge clk or negedge resetn) begin
    if (!resetn) begin
        y_counter <= 2'b00;
    end else if (current_state == STATE_D) begin
        if (y_counter < 2'b10)
            y_counter <= y_counter + 1'b1;
    end
end

always @(*) begin
    // Default assignments
    next_state = current_state;
    f = 1'b0;
    g = 1'b0;

    case (current_state)
        STATE_A: begin
            f = 1'b0;
            g = 1'b0;
            if (resetn) begin // Transition when resetn is asserted
                next_state = STATE_B;
            end
        end

        STATE_B: begin
            f = 1'b1; // Set f to 1 for one cycle
            next_state = STATE_C;
        end

        STATE_C: begin
            f = 1'b0; // Reset f after one cycle
            if (x == 1'b1) begin
                next_state = STATE_D;
            end
        end

        STATE_D: begin
            if (x == 1'b0) begin
                next_state = STATE_E;
            end
        end

        STATE_E: begin
            if (x == 1'b1) begin
                g = 1'b1; // Set g to 1 after x = 1,0,1 pattern
                next_state = STATE_F;
            end else begin
                next_state = STATE_D; // Go back if pattern not matched
            end
        end

        STATE_F: begin
            g = 1'b1; // Maintain g = 1
            if (y == 1'b1) begin
                // Maintain g = 1 permanently
                next_state = STATE_F;
            end else if (y_counter == 2'b10) begin
                // After 2 cycles of checking, if y is not 1 then set g = 0
                g = 1'b0;
                next_state = STATE_A;
            end
        end

        default: next_state = STATE_A; // Default state
    endcase
end

endmodule
