module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum logic [1:0] {
        state_A = 2'b00,
        state_B = 2'b01,
        state_C = 2'b10
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= state_A;
            w_count <= 2'b00;
            z <= 0;
        end else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always_comb begin
        next_state = state; // Default to current state
        z = 0; // Default output

        case (state)
            state_A: begin
                if (s) begin
                    next_state = state_B;
                    w_count = 2'b00;
                end
            end
            state_B: begin
                if (w_count == 2'b11) begin
                    if (w) w_count = w_count + 1;
                    if (w_count == 2'b10)
                        z = 1;
                    w_count = 2'b00;
                end else begin
                    if (w) 
                        w_count = w_count + 1;
                    next_state = state_C;
                end
            end
            state_C: begin
                if (!s) begin
                    next_state = state_A;
                end else begin
                    next_state = state_B;
                end
            end
            default: next_state = state_A;
        endcase
    end

endmodule
