module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // Define state encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t current_state, next_state;
    reg [1:0] w_count;  // counter for 'w' = 1

    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= A;
            w_count <= 2'b00;
            z <= 1'b0;
        end else begin
            current_state <= next_state;
            if (current_state == B) begin
                if (w) w_count <= w_count + 1;
                if (w_count == 2) z <= 1'b1;
                else z <= 1'b0;
            end else if (current_state == A) begin
                w_count <= 2'b00;
                z <= 1'b0;
            end
        end
    end

    always_comb begin
        case (current_state)
            A: begin
                if (s) next_state = B;
                else next_state = A;
            end
            B: begin
                if (w_count >= 2) begin
                    next_state = A;
                    w_count = 0;
                end else begin
                    next_state = B;
                end
            end
            default: next_state = A;
        endcase
    end

endmodule
