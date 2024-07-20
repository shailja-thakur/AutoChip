module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State Encoding
    typedef enum logic [1:0] {
        A = 2'b00,  // Initial state
        B = 2'b01,  // Count w cycles
        C = 2'b10,  // Count w cycles
        D = 2'b11   // Count w cycles
    } state_t;
    state_t state, next_state;
    int count;

    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            count <= 0;
            z <= 0;
        end
        else begin
            state <= next_state;
        end
    end

    always_comb begin
        next_state = state;
        z = 0;
        case (state)
            A: begin
                if (s) begin
                    next_state = B;
                    count = 0;
                end
            end
            B: begin 
                count = count + w;
                if (count == 2) z = 1;
                next_state = C;
            end
            C: begin 
                count = count + w;
                if (count == 2) z = 1;
                next_state = D;
            end
            D: begin
                count = count + w;
                if (count == 2) z = 1;
                next_state = B;  // circular check
                count = 0;
            end
        endcase
    end
endmodule
