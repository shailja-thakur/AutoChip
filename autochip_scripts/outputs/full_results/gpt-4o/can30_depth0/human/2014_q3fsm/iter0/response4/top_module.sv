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
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            z <= 0;
        end else begin
            state <= next_state;
            if (state != A && state != B) begin
                w_count <= w_count + w;
            end
        end
    end

    always_comb begin
        next_state = state;
        z = 0;
        case (state)
            A: begin
                if (s) begin
                    next_state = B;
                end else begin
                    next_state = A;
                end
            end
            B: begin
                next_state = C;
                w_count = 0;
            end
            C: begin
                if (w_count == 2) begin
                    next_state = D;
                    z = 1;
                end else begin
                    next_state = B;
                end
            end
            D: begin
                next_state = B;
                w_count = 0;
            end
            default: next_state = A;
        endcase
    end

endmodule
