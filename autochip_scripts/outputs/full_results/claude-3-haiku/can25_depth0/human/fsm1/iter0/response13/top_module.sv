module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    reg [1:0] state, next_state;
    parameter A = 2'b00, B = 2'b01;

    always @(posedge clk, posedge areset) begin
        if (areset) begin
            state <= B;
        end
        else begin
            state <= next_state;
        end
    end

    always @(*) begin
        case (state)
            A: begin
                if (in) begin
                    next_state = A;
                    out = 0;
                end
                else begin
                    next_state = B;
                    out = 0;
                end
            end
            B: begin
                if (in) begin
                    next_state = B;
                    out = 1;
                end
                else begin
                    next_state = A;
                    out = 0;
                end
            end
            default: begin
                next_state = B;
                out = 0;
            end
        endcase
    end

endmodule
