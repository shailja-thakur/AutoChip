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
    reg [1:0] w_count; // Counter for w=1 occurrences in 3 clock cycles

    // State transition logic (combinational)
    always @(*) begin
        next_state = state; // Default stay in the same state
        case (state)
            A: if (s) next_state = B;
            B: if (w_count == 2) next_state = C;
               else next_state = B;
            C: next_state = D;
            D: next_state = B;
            default: next_state = A;
        endcase
    end

    // Output and counter logic (sequential)
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            z <= 0;
            w_count <= 0;
        end else begin
            state <= next_state;
            
            if (state == B) begin
                if (w_count < 2) 
                    w_count <= w_count + w;
                else
                    w_count <= 0;

                if (w_count == 1 && w == 1) z <= 1;
                else z <= 0;
            end else begin
                w_count <= 0;
                z <= 0;
            end
        end
    end
endmodule
