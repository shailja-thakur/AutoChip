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
        B1 = 2'b01,
        B2 = 2'b10,
        B3 = 2'b11
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count;

    // State transition: Synchronous process
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            z <= 1'b0;
        end
        else begin
            state <= next_state;
            if (state == B1 || state == B2 || state == B3) begin
                if (w) w_count <= w_count + 1'b1;
            end
            z <= 1'b0; // Default value
            if (state == B3) begin
                if (w_count == 2'b10) z <= 1'b1;
                w_count <= 2'b00; // Reset w_count after 3 cycles
            end
        end
    end

    // Next state logic: Combinational process
    always_comb begin
        next_state = state;
        case(state)
            A: begin
                if (s) begin
                    next_state = B1;
                end
            end

            B1: begin
                next_state = B2;
            end

            B2: begin
                next_state = B3;
            end

            B3: begin
                next_state = B1; // Go back to B1 to check w for next 3 cycles
            end

            default: next_state = A;
        endcase
    end

endmodule
