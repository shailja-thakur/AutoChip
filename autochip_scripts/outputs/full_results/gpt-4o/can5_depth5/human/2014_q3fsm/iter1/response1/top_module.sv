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

    // State transition
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            z <= 1'b0;
        end
        else begin
            state <= next_state;
        end
    end

    // Next state and output logic
    always_comb begin
        next_state = state;
        z = 1'b0;
        case(state)
            A: begin
                if (s == 1'b1) begin
                    next_state = B1;
                end
                else begin
                    next_state = A;
                end
            end

            B1: begin
                w_count = (w == 1'b1) ? (w_count + 1) : w_count;
                next_state = B2;
            end

            B2: begin
                w_count = (w == 1'b1) ? (w_count + 1) : w_count;
                next_state = B3;
            end

            B3: begin
                w_count = (w == 1'b1) ? (w_count + 1) : w_count;
                if (w_count == 2'b10) begin
                    z = 1'b1;
                end
                else begin
                    z = 1'b0;
                end
                next_state = B1;
                w_count = 2'b00; // Reset count for the next 3-cycle checking period
            end

            default: begin
                next_state = A;
            end
        endcase
    end

endmodule
