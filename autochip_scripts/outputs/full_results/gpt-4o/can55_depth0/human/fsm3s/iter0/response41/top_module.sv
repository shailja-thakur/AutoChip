module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;

    state_t curr_state, next_state;

    // State transition logic
    always @(*) begin
        case (curr_state)
            A: begin
                next_state = in ? B : A;
                out = 0;
            end
            B: begin
                next_state = in ? B : C;
                out = 0;
            end
            C: begin
                next_state = in ? D : A;
                out = 0;
            end
            D: begin
                next_state = in ? B : C;
                out = 1;
            end
            default: begin
                next_state = A;
                out = 0;
            end
        endcase
    end

    // State flip-flops with synchronous reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            curr_state <= A;
        end else begin
            curr_state <= next_state;
        end
    end

endmodule
