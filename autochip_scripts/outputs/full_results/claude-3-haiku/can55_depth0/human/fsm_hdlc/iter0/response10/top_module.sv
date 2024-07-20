module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states of the Moore FSM
localparam [1:0] IDLE = 2'b00, DETECT1 = 2'b01, DETECT2 = 2'b10, DETECT3 = 2'b11;

// Internal state register
reg [1:0] state, next_state;

// State transition and output logic
always @(posedge clk) begin
    if (reset) begin
        state <= IDLE;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            IDLE: begin
                disc <= 0;
                flag <= 0;
                err <= 0;
                if (in) begin
                    next_state <= DETECT1;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            DETECT1: begin
                if (in) begin
                    next_state <= DETECT2;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            DETECT2: begin
                if (in) begin
                    next_state <= DETECT3;
                end
                else begin
                    next_state <= IDLE;
                end
            end
            DETECT3: begin
                if (in) begin
                    disc <= 1;
                    next_state <= DETECT1;
                end
                else begin
                    flag <= 1;
                    next_state <= IDLE;
                end
            end
            default: begin
                next_state <= IDLE;
            end
        endcase
    end
end

endmodule
