module top_module(
    input clk,
    input reset,
    output shift_ena,
    output reg [2:0] state);

    reg [2:0] next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= 3'b0;
        end else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            3'b0: begin
                next_state = 3'b1;
                shift_ena = 1'b1;
            end
            3'b1: begin
                next_state = 3'b10;
                shift_ena = 1'b1;
            end
            3'b10: begin
                next_state = 3'b11;
                shift_ena = 1'b1;
            end
            3'b11: begin
                next_state = 3'b100;
                shift_ena = 1'b1;
            end
            default: begin
                next_state = 3'b100;
                shift_ena = 1'b0;
            end
        endcase
    end

endmodule
