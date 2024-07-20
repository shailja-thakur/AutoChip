module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    localparam A = 1'b0, B = 1'b1;
    reg state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            B: begin
                if (in == 1'b0) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            A: begin
                if (in == 1'b0) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            default: begin
                next_state = B;
            end
        endcase
    end

    // Output logic
    always @(*) begin
        case (state)
            B: begin
                out = 1'b1;
            end
            A: begin
                out = 1'b0;
            end
            default: begin
                out = 1'b0;
            end
        endcase
    end

    // State register
    always @(posedge clk) begin
        if (reset) begin
            state <= B;
        end else begin
            state <= next_state;
        end
    end

endmodule
