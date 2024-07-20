module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    reg [1:0] state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            state <= S0;
            start_shifting <= 0;
        end
        else begin
            state <= next_state;
            if (state == S3)
                start_shifting <= 1;
        end
    end

    always @(*) begin
        case (state)
            S0: next_state = (data) ? S1 : S0;
            S1: next_state = (data) ? S2 : S0;
            S2: next_state = (data) ? S3 : S1;
            S3: next_state = (data) ? S0 : S3;
            default: next_state = S0;
        endcase
    end

endmodule
