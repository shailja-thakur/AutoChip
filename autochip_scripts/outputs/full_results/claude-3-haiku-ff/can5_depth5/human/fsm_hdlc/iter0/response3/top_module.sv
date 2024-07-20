module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states for the finite state machine
parameter WAIT = 3'b000, ONE = 3'b001, TWO = 3'b010, THREE = 3'b011, FOUR = 3'b100, FIVE = 3'b101, SIX = 3'b110, SEVEN = 3'b111;

// Internal state register
reg [2:0] state, next_state;

// Next state logic
always @(*) begin
    case (state)
        WAIT: begin
            if (in == 1'b0) next_state = WAIT;
            else next_state = ONE;
        end
        ONE: begin
            if (in == 1'b0) next_state = WAIT;
            else next_state = TWO;
        end
        TWO: begin
            if (in == 1'b0) next_state = WAIT;
            else next_state = THREE;
        end
        THREE: begin
            if (in == 1'b0) next_state = WAIT;
            else next_state = FOUR;
        end
        FOUR: begin
            if (in == 1'b0) next_state = WAIT;
            else next_state = FIVE;
        end
        FIVE: begin
            if (in == 1'b0) begin
                next_state = WAIT;
                disc = 1'b1;
            end
            else next_state = SIX;
        end
        SIX: begin
            if (in == 1'b0) begin
                next_state = WAIT;
                flag = 1'b1;
            end
            else next_state = SEVEN;
        end
        SEVEN: begin
            if (in == 1'b0) begin
                next_state = WAIT;
                err = 1'b1;
            end
            else next_state = SEVEN;
        end
    endcase
end

// State update logic
always @(posedge clk) begin
    if (reset) begin
        state <= WAIT;
        disc <= 1'b0;
        flag <= 1'b0;
        err <= 1'b0;
    end
    else begin
        state <= next_state;
        disc <= 1'b0;
        flag <= 1'b0;
        err <= 1'b0;
    end
end

endmodule
