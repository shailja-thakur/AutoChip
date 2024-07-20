module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting);

    reg [3:0] state;
    reg [3:0] shift_reg;

    always @(posedge clk) begin
        if (reset) begin
            state <= 0;
            shift_reg <= 0;
            start_shifting <= 0;
        end else begin
            shift_reg <= {shift_reg[2:0], data};
            case (state)
                0: begin
                    if (shift_reg == 4'b1101)
                        state <= 1;
                end
                1: begin
                    state <= 0;
                    start_shifting <= 1;
                end
                default: state <= 0;
            endcase
        end
    end
endmodule
