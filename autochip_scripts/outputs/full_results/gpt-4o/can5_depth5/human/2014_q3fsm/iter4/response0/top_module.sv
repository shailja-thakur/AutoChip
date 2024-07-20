module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);
    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00, // Wait for s=1
        B = 2'b01, // Count w's in the first clock cycle
        C = 2'b10, // Count w's in the second clock cycle
        D = 2'b11  // Count w's in the third clock cycle
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

            if (state == B || state == C || state == D) begin
                if (w) w_count <= w_count + 1'b1;
            end
        end
    end

    // Next state logic: Combinational process
    always_comb begin
        next_state = state;
        z = 1'b0;
        case(state)
            A: begin
                if (s == 1'b1) begin
                    next_state = B;
                    w_count = 2'b00;
                end
            end
            B: begin
                next_state = C;
            end
            C: begin
                next_state = D;
            end
            D: begin
                if (w_count == 2'b10) begin
                    z = 1'b1;
                end
                next_state = B;
                w_count = 2'b00;
            end
        endcase
    end

endmodule
