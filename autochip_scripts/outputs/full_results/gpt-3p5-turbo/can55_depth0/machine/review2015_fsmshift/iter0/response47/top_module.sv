module top_module(
    input clk,
    input reset,
    output reg shift_ena);

    reg [2:0] state;

    always @(posedge clk) begin
        if(reset) begin
            state <= 0;
        end else begin
            case(state)
                0: begin
                    state <= 1;
                end
                1: begin
                    state <= 2;
                end
                2: begin
                    state <= 3;
                end
                3: begin
                    state <= 4;
                end
                default: begin
                    state <= 4;
                end
            endcase
        end
    end

    assign shift_ena = (state == 0 || state == 1 || state == 2 || state == 3);

endmodule
