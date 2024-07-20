module top_module(
    input clk,
    input reset,
    input data,
    output reg start_shifting
);

    reg [1:0] current_state, next_state;
    parameter S0 = 2'b00, S1 = 2'b01, S2 = 2'b10, S3 = 2'b11;

    always @(posedge clk) begin
        if (reset) begin
            current_state <= S0;
        end
        else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case (current_state)
            S0: begin
                if (data == 1'b1) begin
                    next_state = S1;
                end
                else begin
                    next_state = S0;
                end
                start_shifting = 1'b0;
            end
            S1: begin
                if (data == 1'b1) begin
                    next_state = S2;
                end
                else begin
                    next_state = S0;
                end
                start_shifting = 1'b0;
            end
            S2: begin
                if (data == 1'b0) begin
                    next_state = S3;
                end
                else begin
                    next_state = S1;
                end
                start_shifting = 1'b0;
            end
            S3: begin
                if (data == 1'b1) begin
                    next_state = S1;
                end
                else begin
                    next_state = S0;
                end
                start_shifting = 1'b1;
            end
            default: begin
                next_state = S0;
                start_shifting = 1'b0;
            end
        endcase
    end

endmodule
