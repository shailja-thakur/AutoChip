module top_module(
    input clk,
    input reset,
    output shift_ena,
    output reg [2:0] state
    );

    reg [2:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= 3'b000;
        end else begin
            state <= next_state;
        end
    end

    always @(state) begin
        case (state)
            3'b000: begin
                if (reset) begin
                    next_state = 3'b000;
                end else begin
                    next_state = 3'b001;
                end
                shift_ena = 1'b1;
            end
            3'b001: begin
                next_state = 3'b010;
                shift_ena = 1'b1;
            end
            3'b010: begin
                next_state = 3'b011;
                shift_ena = 1'b1;
            end
            3'b011: begin
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
