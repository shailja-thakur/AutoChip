module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    typedef enum reg [1:0] {A = 2'b00, B = 2'b01} state_t;
    state_t current_state, next_state;

    // Synchronous state transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= B;
        end else begin
            current_state <= next_state;
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            B: begin
                if (in) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            A: begin
                if (in) begin
                    next_state = A;
                end else begin
                    next_state = B;
                end
            end
            default: begin
                next_state = B;
            end
        endcase
    end

    // Output logic
    always @(posedge clk) begin
        if (reset) begin
            out <= 1;
        end else begin
            case (current_state)
                B: out <= 1;
                A: out <= 0;
                default: out <= 1;
            endcase
        end
    end

endmodule
