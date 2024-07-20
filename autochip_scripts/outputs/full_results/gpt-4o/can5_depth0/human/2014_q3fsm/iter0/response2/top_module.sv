module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    // State encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10
    } state_t;

    state_t current_state, next_state;
    reg [1:0] w_count;
    reg [1:0] w_counter;

    // State transition
    always @(posedge clk) begin
        if (reset) begin
            current_state <= A;
            w_count <= 0;
            w_counter <= 0;
            z <= 0;
        end
        else begin
            current_state <= next_state;
            if (current_state == B) begin
                w_counter <= w_counter + 1;
                if (w) begin
                    w_count <= w_count + 1;
                end
                if (w_counter == 2'b10) begin
                    z <= (w_count == 2);
                    w_count <= 0;
                    w_counter <= 0;
                end
            end else begin
                w_count <= 0;
                w_counter <= 0;
                z <= 0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case (current_state)
            A: next_state = (s) ? B : A;
            B: next_state = (w_counter == 2'b10) ? B : B; // Stay in B and continue to count
            default: next_state = A;
        endcase
    end

endmodule
