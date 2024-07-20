module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states of the FSM
localparam [2:0] 
    S_IDLE = 3'b000,
    S_ONE  = 3'b001,
    S_TWO  = 3'b010,
    S_THREE= 3'b011,
    S_FOUR = 3'b100,
    S_FIVE = 3'b101,
    S_SIX  = 3'b110,
    S_SEVEN= 3'b111;

reg [2:0] state, next_state;

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        state <= S_IDLE;
    end else begin
        state <= next_state;
    end
end

always @(*) begin
    // Default outputs
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    // Next state logic
    case (state)
        S_IDLE: begin
            if (in == 1'b1) begin
                next_state = S_ONE;
            end else begin
                next_state = S_IDLE;
            end
        end
        S_ONE: begin
            if (in == 1'b1) begin
                next_state = S_TWO;
            end else begin
                next_state = S_IDLE;
            end
        end
        S_TWO: begin
            if (in == 1'b1) begin
                next_state = S_THREE;
            end else begin
                next_state = S_IDLE;
            end
        end
        S_THREE: begin
            if (in == 1'b1) begin
                next_state = S_FOUR;
            end else begin
                next_state = S_IDLE;
            end
        end
        S_FOUR: begin
            if (in == 1'b1) begin
                next_state = S_FIVE;
            end else begin
                next_state = S_IDLE;
            end
        end
        S_FIVE: begin
            if (in == 1'b1) begin
                next_state = S_SIX;
                disc = 1'b1;
            end else begin
                next_state = S_IDLE;
            end
        end
        S_SIX: begin
            if (in == 1'b1) begin
                next_state = S_SEVEN;
                flag = 1'b1;
            end else begin
                next_state = S_IDLE;
            end
        end
        S_SEVEN: begin
            if (in == 1'b1) begin
                next_state = S_SEVEN;
                err = 1'b1;
            end else begin
                next_state = S_IDLE;
            end
        end
        default: begin
            next_state = S_IDLE;
        end
    endcase
end

endmodule
