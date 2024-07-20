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
    logic [1:0] w_count; // Counter for the number of w=1 in the last three clock cycles
    logic [1:0] cycle_count; // Counter for cycles

    // State transition (sequential logic)
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            cycle_count <= 2'b00;
            z <= 1'b0;
        end else begin
            state <= next_state;

            if (state == B || state == C || state == D) begin
                if (w) w_count <= w_count + 2'b01;
                cycle_count <= cycle_count + 2'b01;
            end

            if (cycle_count == 2'b10) begin
                if (state == D && w_count == 2'b10) z <= 1'b1;
                else z <= 1'b0;
                
                w_count <= 2'b00;
                cycle_count <= 2'b00;
            end else z <= 1'b0;
        end
    end

    // Next state logic (combinational logic)
    always @(*) begin
        case (state)
            A: begin
                if (s) next_state = B;
                else next_state = A;
            end
            B: begin
                if (cycle_count == 2'b10) next_state = B;
                else next_state = C;
            end
            C: begin
                if (cycle_count == 2'b10) next_state = B;
                else next_state = D;
            end
            D: begin
                if (cycle_count == 2'b10) next_state = B;
                else next_state = D;
            end
            default: next_state = A;
        endcase
    end

endmodule
