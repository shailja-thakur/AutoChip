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
    reg [1:0] counter; // To count the number of times w = 1 in the three cycles

    // State transition
    always_ff @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            counter <= 2'b00;
            z <= 1'b0;
        end else begin
            state <= next_state;
            if (state == B && next_state == A) begin
                if (counter == 2'b10)
                    z <= 1'b1;
                else
                    z <= 1'b0;
            end else if (next_state != B) begin
                z <= 1'b0;
            end

            if (next_state == B && state == A) begin
                counter <= 2'b00;
            end else if (next_state == B) begin
                counter <= counter + w;
            end
        end
    end

    // Next state logic
    always_comb begin
        case (state)
            A: if (s) next_state = B; else next_state = A;
            B: if (counter == 2'b10) next_state = A; else next_state = B;
            default: next_state = A;
        endcase
    end

endmodule
