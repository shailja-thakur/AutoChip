module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    parameter WAIT_STATE = 2'b00;
    parameter ENABLE_STATE = 2'b01;
    parameter DISABLE_STATE = 2'b10;

    reg [1:0] state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= WAIT_STATE;
            shift_ena <= 1'b0;
        end
        else begin
            state <= next_state;
            case (state)
                WAIT_STATE: begin
                    shift_ena <= 1'b0;
                end
                ENABLE_STATE: begin
                    shift_ena <= 1'b1;
                end
                DISABLE_STATE: begin
                    shift_ena <= 1'b0;
                end
            endcase
        end
    end

    always @(*) begin
        case (state)
            WAIT_STATE: begin
                next_state = ENABLE_STATE;
            end
            ENABLE_STATE: begin
                if (shift_ena) begin
                    next_state = DISABLE_STATE;
                end
                else begin
                    next_state = ENABLE_STATE;
                end
            end
            DISABLE_STATE: begin
                next_state = WAIT_STATE;
            end
        endcase
    end

endmodule
