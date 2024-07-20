module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states of the finite state machine
localparam STATE_IDLE = 3'b000;
localparam STATE_ONE  = 3'b001;
localparam STATE_TWO  = 3'b010;
localparam STATE_THR  = 3'b011;
localparam STATE_FOU  = 3'b100;
localparam STATE_FIV  = 3'b101;
localparam STATE_SIX  = 3'b110;

reg [2:0] current_state, next_state;

always @(posedge clk) begin
    if (reset) begin
        current_state <= STATE_IDLE;
    end else begin
        current_state <= next_state;
    end
end

always @(*) begin
    // Default output values
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    // Next state logic
    case (current_state)
        STATE_IDLE: begin
            if (in == 1'b1) begin
                next_state = STATE_ONE;
            end else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_ONE: begin
            if (in == 1'b1) begin
                next_state = STATE_TWO;
            end else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_TWO: begin
            if (in == 1'b1) begin
                next_state = STATE_THR;
            end else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_THR: begin
            if (in == 1'b1) begin
                next_state = STATE_FOU;
            end else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_FOU: begin
            if (in == 1'b1) begin
                next_state = STATE_FIV;
            end else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_FIV: begin
            if (in == 1'b1) begin
                next_state = STATE_SIX;
                disc = 1'b1;
            end else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_SIX: begin
            if (in == 1'b0) begin
                next_state = STATE_IDLE;
                flag = 1'b1;
            end else begin
                next_state = STATE_SIX;
                err = 1'b1;
            end
        end
        default: begin
            next_state = STATE_IDLE;
        end
    endcase
end

endmodule
