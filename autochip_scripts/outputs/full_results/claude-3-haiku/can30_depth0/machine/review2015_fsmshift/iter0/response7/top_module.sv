module top_module(
    input clk,
    input reset,
    output reg shift_ena
);

    reg [2:0] state;
    parameter B0 = 3'd0, B1 = 3'd1, B2 = 3'd2, B3 = 3'd3, DONE = 3'd4;

    always @(posedge clk) begin
        if (reset) begin
            state <= B0;
        end
        else begin
            case (state)
                B0: state <= B1;
                B1: state <= B2;
                B2: state <= B3;
                B3: state <= DONE;
                DONE: state <= DONE;
                default: state <= B0;
            endcase
        end
    end

    always @(*) begin
        case (state)
            B0, B1, B2, B3: shift_ena = 1'b1;
            default: shift_ena = 1'b0;
        endcase
    end

endmodule
