module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State definitions
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        CHECK1 = 2'b10,
        CHECK2 = 2'b11
    } state_t;

    state_t state, next_state;
    reg [1:0] w_count;

    // State transition logic
    always_ff @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            z <= 1'b0;
        end else begin
            state <= next_state;
        end
    end
    
    // Next state logic and output logic
    always_comb begin
        case (state)
            A: begin
                z = 1'b0;
                if (s) next_state = B;
                else next_state = A;
            end
            B: begin
                next_state = CHECK1;
            end
            CHECK1: begin
                w_count = (w_count + w);
                next_state = CHECK2;
            end
            CHECK2: begin
                w_count = (w_count + w);
                if (w_count == 2'b10) next_state = A;
                else next_state = B;
                if (w_count == 2'b10) z = 1'b1;
                else z = 1'b0;
            end
        endcase
    end
    
    // Reset w_count whenever transitioning out of state A
    always_ff @(posedge clk) begin
        if (state == A || state == B) begin
            w_count <= 2'b00;
        end
    end

endmodule
