module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states of the finite state machine
parameter IDLE = 2'b00, WAIT_5 = 2'b01, WAIT_6 = 2'b10, ERROR = 2'b11;

// Register to hold the current state
reg [1:0] state;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= IDLE;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        case (state)
            IDLE: begin
                if (in) begin
                    state <= WAIT_5;
                end
                else begin
                    state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            WAIT_5: begin
                if (in) begin
                    state <= WAIT_6;
                end
                else begin
                    state <= IDLE;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            WAIT_6: begin
                if (in) begin
                    state <= ERROR;
                    err <= 1;
                end
                else begin
                    state <= IDLE;
                    disc <= 0;
                    flag <= 1;
                end
            end
            ERROR: begin
                if (in) begin
                    state <= ERROR;
                    err <= 1;
                end
                else begin
                    state <= IDLE;
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            end
            default: begin
                state <= IDLE;
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
        endcase
    end
end

endmodule
