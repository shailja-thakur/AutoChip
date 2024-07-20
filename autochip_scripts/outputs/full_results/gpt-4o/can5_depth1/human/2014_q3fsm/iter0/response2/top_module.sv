module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // State encodings
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10
    } state_t;
    
    state_t state, next_state;
    reg [1:0] w_count;
    reg [1:0] cycle_count;

    // State transition and output logic
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 0;
            cycle_count <= 0;
            z <= 0;
        end else begin
            state <= next_state;
            if (state == B) begin
                if (cycle_count == 2) begin
                    if (w_count == 2) z <= 1;
                    else z <= 0;
                    w_count <= 0;  // Reset counting for next 3 cycles
                    cycle_count <= 0;
                end else begin
                    w_count <= w_count + w;
                    cycle_count <= cycle_count + 1;
                end
            end else begin
                z <= 0;
            end
        end
    end

    // Next state logic
    always @(*) begin
        case ({state, s})
            {A, 1'b0}: next_state = A;
            {A, 1'b1}: next_state = B;
            default: next_state = B;  // Stay in B if state is B or others
        endcase
    end

endmodule
