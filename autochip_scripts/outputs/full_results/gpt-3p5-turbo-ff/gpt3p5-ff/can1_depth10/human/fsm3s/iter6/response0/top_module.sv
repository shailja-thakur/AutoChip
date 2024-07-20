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
                end else begin
                    next_state <= B;
                end
                out <= 0;
            end

            B: begin
                if (in == 1) begin
                    next_state <= C;
                end else begin
                    next_state <= B;
                end
                out <= 0;
            end

            C: begin
                if (in == 1) begin
                    next_state <= D;
                end else begin
                    next_state <= A;
                end
                out <= 0;
            end

            D: begin
                if (in == 1) begin
                    next_state <= B;
                end else begin
                    next_state <= C;
                end
                out <= 1;
            end
        endcase
    end
endmodule
