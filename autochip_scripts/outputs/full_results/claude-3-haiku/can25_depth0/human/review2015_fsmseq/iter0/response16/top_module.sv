module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;
    reg [1:0] current_state, next_state;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
            start_shifting <= 0;
        end
        else begin
            current_state <= next_state;
            if (current_state == S3)
                start_shifting <= 1;
        end
    end

    always @(*) begin
        case (current_state)
            S0: begin
                if (data == 1)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                if (data == 0)
                    next_state = S2;
                else
                    next_state = S0;
            end
            S2: begin
                if (data == 1)
                    next_state = S3;
                else
                    next_state = S0;
            end
            S3: begin
                if (data == 1)
                    next_state = S1;
                else
                    next_state = S0;
            end
            default: next_state = S0;
        endcase
    end

endmodule
