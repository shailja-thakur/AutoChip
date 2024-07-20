module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    reg [1:0] state, next_state;

    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else if (state == A) begin
            if (in) begin
                next_state <= B;
            end else begin
                next_state <= A;
            end
        end else if (state == B) begin
            if (in) begin
                next_state <= B;
            end else begin
                next_state <= C;
            end
        end else if (state==C) begin
            if (in) begin
                next_state <= D;
            end else begin
                next_state <= A;
            end
        end else if (state == D) begin
            if (in) begin
                next_state <= B;
            end else begin
                next_state <= C;
            end
        end
    end

    always @(posedge clk) begin
        state <= next_state;
        if (state == D) begin
            out <= 1;
        end else begin
            out <= 0;
        end
    end

endmodule
