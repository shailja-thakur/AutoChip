module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

reg [3:0] state;

always @(posedge clk) begin
    if (reset)
        state <= 0;
    else begin
        case (state)
            0: begin
                if (data)
                    state <= 1;
                else
                    state <= 0;
            end
            1: begin
                if (data)
                    state <= 2;
                else
                    state <= 0;
            end
            2: begin
                if (data)
                    state <= 2;
                else
                    state <= 3;
            end
            3: begin
                if (data)
                    start_shifting <= 1;
                state <= 0;
            end
            default: state <= 0;
        endcase
    end
end

endmodule
