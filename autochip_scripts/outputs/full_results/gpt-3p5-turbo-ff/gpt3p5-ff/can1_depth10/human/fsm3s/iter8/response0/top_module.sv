module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    parameter A = 2'b00;
    parameter B = 2'b01;
    parameter C = 2'b10;
    parameter D = 2'b11;

    reg [1:0] current_state;
    reg [1:0] next_state;

    always @(posedge clk or posedge reset) begin
        if (reset == 1) begin
            current_state <= A;
        end else begin
            current_state <= next_state;
        end
    end

    always @(current_state or in) begin
        case (current_state)
            A: begin
                if (in == 1) begin
                    next_state <= B;
                    out <= 0;
                end else begin
                    next_state <= B;
                    out <= 0;
                end
            end

            B: begin
                if (in == 1) begin
                    next_state <= C;
                    out <= 0;
                end else begin
                    next_state <= B;
                    out <= 0;
                end
            end

            C: begin
                if (in == 1) begin
                    next_state <= D;
                    out <= 0;
                end else begin
                    next_state <= A;
                    out <= 0;
                end
            end

            D: begin
                if (in == 1) begin
                    next_state <= B;
                    out <= 1;
                end else begin
                    next_state <= C;
                    out <= 0;
                end
            end
        endcase
    end
endmodule
