module top_module(
    input clk,
    input reset,
    input data,
    output reg shift_ena,
    output reg counting,
    input done_counting,
    output reg done,
    input ack
);

parameter S0 = 3'd0, S1 = 3'd1, S2 = 3'd2, S3 = 3'd3, S4 = 3'd4, S5 = 3'd5, S6 = 3'd6;
reg [2:0] state, next_state;
reg [3:0] shift_count;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        state <= S0;
        shift_count <= 0;
        shift_ena <= 0;
        counting <= 0;
        done <= 0;
    end
    else begin
        state <= next_state;
        case (state)
            S0: begin // Waiting for start sequence 1101
                shift_ena <= 0;
                counting <= 0;
                done <= 0;
                if (data == 1'b1) begin
                    next_state <= S1;
                end
                else begin
                    next_state <= S0;
                end
            end
            S1: begin // Detected first bit of start sequence
                if (data == 1'b1) begin
                    next_state <= S2;
                end
                else begin
                    next_state <= S0;
                end
            end
            S2: begin // Detected second bit of start sequence
                if (data == 1'b0) begin
                    next_state <= S3;
                end
                else begin
                    next_state <= S0;
                end
            end
            S3: begin // Detected third bit of start sequence
                if (data == 1'b1) begin
                    next_state <= S4;
                end
                else begin
                    next_state <= S0;
                end
            end
            S4: begin // Detected fourth bit of start sequence, start shifting in duration
                shift_ena <= 1;
                shift_count <= 0;
                next_state <= S5;
            end
            S5: begin // Shifting in duration
                shift_count <= shift_count + 1;
                if (shift_count == 4) begin
                    shift_ena <= 0;
                    counting <= 1;
                    next_state <= S6;
                end
                else begin
                    next_state <= S5;
                end
            end
            S6: begin // Waiting for timer to finish
                if (done_counting) begin
                    counting <= 0;
                    done <= 1;
                    next_state <= S0;
                end
                else begin
                    next_state <= S6;
                end
            end
            default: begin
                next_state <= S0;
            end
        endcase
    end
end

endmodule
