module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum logic [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
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
                next_state = C;
                w_count = w_count + w;
            end
            
            C: begin
                next_state = D;
                w_count = w_count + w;
            end
            
            D: begin
                next_state = E;
                w_count = w_count + w;
            end
            
            E: begin
                if (w_count == 2'b10) begin
                    z = 1'b1;
                end
                w_count = 2'b00;
                next_state = B;
            end
            
            default: next_state = A;
        endcase
    end

endmodule
