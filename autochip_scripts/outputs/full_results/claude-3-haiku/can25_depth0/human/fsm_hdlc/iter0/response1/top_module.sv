module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states of the FSM
localparam STATE_IDLE = 2'b00;
localparam STATE_DISCOVER = 2'b01;
localparam STATE_FLAG = 2'b10;
localparam STATE_ERROR = 2'b11;

// Declare the state register and next state logic
reg [1:0] state, next_state;

// Next state logic
always @(*) begin
    case (state)
        STATE_IDLE: begin
            if (in == 1'b1) begin
                next_state = STATE_DISCOVER;
            end else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_DISCOVER: begin
            if (in == 1'b1) begin
                next_state = STATE_FLAG;
            end else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_FLAG: begin
            if (in == 1'b1) begin
                next_state = STATE_ERROR;
            end else begin
                next_state = STATE_IDLE;
            end
        end
        STATE_ERROR: begin
            next_state = STATE_ERROR;
        end
        default: begin
            next_state = STATE_IDLE;
        end
    endcase
end

// Output logic
always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;
    case (state)
        STATE_IDLE: begin
            // Nothing to do
        end
        STATE_DISCOVER: begin
            disc = 1'b1;
        end
        STATE_FLAG: begin
            flag = 1'b1;
        end
        STATE_ERROR: begin
            err = 1'b1;
        end
        default: begin
            // Nothing to do
        end
    endcase
end

// State register
always @(posedge clk) begin
    if (reset) begin
        state <= STATE_IDLE;
    end else begin
        state <= next_state;
    end
end

endmodule
