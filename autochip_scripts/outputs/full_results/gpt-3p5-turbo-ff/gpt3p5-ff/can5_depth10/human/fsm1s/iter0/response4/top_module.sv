module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);
    reg state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= 1'b1;
        else begin
            case(state)
                1'b0: begin
                    if (in)
                        state <= 1'b0;
                    else
                        state <= 1'b1;
                end
                1'b1: begin
                    if (in)
                        state <= 1'b1;
                    else
                        state <= 1'b0;
                end
            endcase
        end
    end

    always @(posedge clk) begin
        case(state)
            1'b0: out <= 1'b0;
            1'b1: out <= 1'b1;
        endcase
    end
endmodule
