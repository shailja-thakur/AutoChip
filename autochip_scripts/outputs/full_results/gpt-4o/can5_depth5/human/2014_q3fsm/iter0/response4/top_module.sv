module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count;

    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
        end
        else begin
            state <= next_state;
        end
    end

    // Next state logic
    always_comb begin
        next_state = state;
        z = 1'b0;
        case(state)
            A: begin
                if (s == 1'b1) begin
                    next_state = B;
                end
            end

            B: begin
                if (w_count == 2'b11) begin
                    z = (w_count == 2'b10); // set z to 1 if w_count is exactly 2 in the last three cycles
                    w_count = 2'b00;
                    next_state = B;
                end
                else if (w == 1'b1) begin
                    w_count = w_count + 1;
                end
                next_state = B;
            end

            default: next_state = A;
        endcase
    end

endmodule
