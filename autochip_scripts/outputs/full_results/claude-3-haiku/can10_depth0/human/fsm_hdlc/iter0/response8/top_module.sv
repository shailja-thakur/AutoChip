module top_module (
    input clk,
    input reset,
    input in,
    output reg disc,
    output reg flag,
    output reg err
);

// Define the states of the FSM
localparam STATE_ZERO = 2'b00;
localparam STATE_ONE  = 2'b01;
localparam STATE_FLAG = 2'b10;
localparam STATE_ERR  = 2'b11;

// Internal state register
reg [1:0] state;

// Next state logic
always @(posedge clk) begin
    if (reset) begin
        state <= STATE_ZERO;
        disc <= 0;
        flag <= 0;
        err <= 0;
    end else begin
        case (state)
            STATE_ZERO: begin
                if (in == 1) begin
                    state <= STATE_ONE;
                end else begin
                    state <= STATE_ZERO;
                end
                disc <= 0;
                flag <= 0;
                err <= 0;
            end
            STATE_ONE: begin
                if (in == 1) begin
                    state <= STATE_ONE;
                    if (state == STATE_ONE && in == 1) begin
                        disc <= 1;
                        flag <= 0;
                        err <= 0;
                    end else begin
                        disc <= 0;
                        flag <= 0;
                        err <= 0;
                    end
                end else begin
                    state <= STATE_ZERO;
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            end
            STATE_FLAG: begin
                if (in == 1) begin
                    state <= STATE_ERR;
                    disc <= 0;
                    flag <= 0;
                    err <= 1;
                end else begin
                    state <= STATE_ZERO;
                    disc <= 0;
                    flag <= 1;
                    err <= 0;
                end
            end
            STATE_ERR: begin
                if (in == 1) begin
                    state <= STATE_ERR;
                    disc <= 0;
                    flag <= 0;
                    err <= 1;
                end else begin
                    state <= STATE_ZERO;
                    disc <= 0;
                    flag <= 0;
                    err <= 0;
                end
            end
        endcase
    end
end

endmodule
