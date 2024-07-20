module top_module (
    input clk,
    input a,
    input b,
    output reg q,
    output reg state
);

    reg q_next;
    reg state_next;

    always @(posedge clk) begin
        case({a, b})
            2'b00: begin
                q_next = 1'b0;
                state_next = 1'b0;
            end

            2'b01: begin
                q_next = 1'b1;
                state_next = 1'b0;
            end

            2'b10: begin
                q_next = 1'b1;
                state_next = 1'b0;
            end

            2'b11: begin
                q_next = 1'b0;
                state_next = 1'b1;
            end

            default: begin
                q_next = 1'b0;
                state_next = 1'b0;
            end
        endcase
    end

    always @(posedge clk) begin
        q <= q_next;
        state <= state_next;
    end

endmodule
