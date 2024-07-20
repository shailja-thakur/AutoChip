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
    reg [1:0] w_count;
    reg [1:0] cycle_count;

    // Sequential logic for state transition and counter updates
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            w_count <= 0;
            cycle_count <= 0;
            z <= 0;
        end else begin
            state <= next_state;
            if (state == B) begin
                cycle_count <= cycle_count + 1;
                if (w) w_count <= w_count + 1;
                if (cycle_count == 2'b11) begin
                    if (w_count == 2'b10)
                        z <= 1;
                    else
                        z <= 0;
                    cycle_count <= 0;
                    w_count <= 0;
                end
            end else begin
                cycle_count <= 0;
                w_count <= 0;
                z <= 0;
            end
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: begin
                if (s) next_state = B;
                else next_state = A;
            end
            B: begin
                if (cycle_count == 2'b11) next_state = B;
                else next_state = B;
            end
            default: next_state = A;
        endcase
    end

endmodule
