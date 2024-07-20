module top_module (
    input clk,
    input j,
    input k,
    input reset,
    output reg out
);

    typedef enum logic [1:0] {A=0, B=1} state_t;
    state_t state, next_state;

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        case (state)
            A: begin
                if (j) next_state = B;
                else next_state = A;
            end
            B: begin
                if (k) next_state = A;
                else next_state = B;
            end
            default: next_state = A;
        endcase
    end

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            out <= 0;
        end else begin
            case (state)
                A: out <= 1'b0;
                B: out <= 1'b1;
                default: out <= 1'b0;
            endcase
        end
    end

endmodule
