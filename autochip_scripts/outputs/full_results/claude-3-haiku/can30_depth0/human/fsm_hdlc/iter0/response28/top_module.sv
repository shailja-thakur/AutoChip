module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states of the finite state machine
parameter IDLE = 2'b00, WAIT1 = 2'b01, WAIT5 = 2'b10, ERROR = 2'b11;

// Internal state register
reg [1:0] state, next_state;

// State transition logic
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
    end
    else begin
        state <= next_state;
    end
end

// Next state logic
always @(*) begin
    case (state)
        IDLE: begin
            if (in == 1'b1) begin
                next_state = WAIT1;
            end
            else begin
                next_state = IDLE;
            end
        end
        WAIT1: begin
            if (in == 1'b1) begin
                next_state = WAIT5;
            end
            else begin
                next_state = IDLE;
            end
        end
        WAIT5: begin
            if (in == 1'b1) begin
                next_state = ERROR;
            end
            else if (in == 1'b0) begin
                next_state = IDLE;
            end
            else begin
                next_state = WAIT5;
            end
        end
        ERROR: begin
            next_state = ERROR;
        end
        default: begin
            next_state = IDLE;
        end
    endcase
end

// Output logic
always @(*) begin
    disc = 1'b0;
    flag = 1'b0;
    err = 1'b0;

    case (state)
        WAIT5: begin
            disc = 1'b1;
        end
        WAIT1: begin
            if (in == 1'b0) begin
                flag = 1'b1;
            end
        end
        ERROR: begin
            err = 1'b1;
        end
        default: begin
            // Do nothing
        end
    endcase
end

endmodule
