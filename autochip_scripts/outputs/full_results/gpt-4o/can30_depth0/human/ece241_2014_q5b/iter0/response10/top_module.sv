module top_module (
    input clk,
    input areset,
    input x,
    output reg z
);

    typedef enum logic [1:0] {A=2'b01, B=2'b10} state_t;
    state_t state, next_state;

    always_ff @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A; // reset to state A
        end else begin
            state <= next_state;
        end
    end

    always_comb begin
        case (state)
            A: if (x) begin
                    next_state = B;
                    z = 1;
               end else begin
                    next_state = A;
                    z = 0;
               end
            B: if (x) begin
                    next_state = B;
                    z = 0;
               end else begin
                    next_state = B;
                    z = 1;
               end
            default: begin
                next_state = A; //default case to prevent latch
                z = 0;
            end
        endcase
    end

endmodule
