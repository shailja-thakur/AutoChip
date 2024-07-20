module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state;
    reg [2:0] next_state;

    always @(posedge clk, posedge reset) begin
        if (reset) begin
            state <= 0;
            shift_ena <= 0;
        end else begin
            state <= next_state;
            shift_ena <= (state == 2'b00) ? 1'b1 : 1'b0;
        end
    end

    always @(state) begin
        case(state)
            2'b00: next_state = 2'b01;
            2'b01: next_state = 2'b10;
            2'b10: next_state = 2'b00;
        endcase
    end
endmodule
