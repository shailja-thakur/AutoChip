module top_module (
    input clk,
    input reset,
    input in,
    output disc,
    output flag,
    output err);

    reg [2:0] state;
    reg [2:0] next_state;

    parameter INIT = 0;
    parameter CHECK_FLAG = 1;
    parameter CHECK_DISCARD = 2;
    parameter CHECK_ERROR = 3;

    always @(posedge clk) begin
        if (reset) begin
            state <= INIT;
        end else begin
            state <= next_state;
        end
    end

    always @(state or in) begin
        next_state = state;
        disc = 0;
        flag = 0;
        err = 0;

        case(state)
            INIT: begin
                if (in) begin
                    next_state = CHECK_FLAG;
                end
            end
            CHECK_FLAG: begin
                if (in) begin
                    next_state = CHECK_DISCARD;
                end else begin
                    next_state = INIT;
                end
            end
            CHECK_DISCARD: begin
                if (in) begin
                    next_state = CHECK_ERROR;
                end else begin
                    next_state = CHECK_FLAG;
                    disc = 1;
                end
            end
            CHECK_ERROR: begin
                if (in) begin
                    next_state = CHECK_ERROR;
                    err = 1;
                end else begin
                    next_state = INIT;
                    flag = 1;
                end
            end
        endcase
    end

endmodule
