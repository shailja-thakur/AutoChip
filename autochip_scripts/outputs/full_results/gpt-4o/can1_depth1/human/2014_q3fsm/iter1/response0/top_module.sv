module top_module (
    input clk,
    input reset,
    input s,
    input w,
    output reg z
);

    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10
    } state_t;

    state_t state, next_state;
    reg [1:0] w_count;
    reg [2:0] cycle_count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A;
            w_count <= 2'b00;
            cycle_count <= 3'b000;
            z <= 0;
        end else begin
            state <= next_state;
            if (state == B && cycle_count < 3) begin
                cycle_count <= cycle_count + 1;
                if (w) w_count <= w_count + 1;
            end else if (state == B && cycle_count == 3) begin
                cycle_count <= 3'b000;
                w_count <= 2'b00;
                z <= (w_count == 2'b10);
            end
        end
    end

    always @(*) begin
        case (state)
            A: next_state = (s) ? B : A;
            B: next_state = (cycle_count == 3'b011) ? C : B;
            C: next_state = (s) ? B : A;
            default: next_state = A;
        endcase
    end

endmodule
