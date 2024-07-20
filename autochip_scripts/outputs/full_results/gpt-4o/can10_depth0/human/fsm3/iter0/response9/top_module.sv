module top_module (
    input clk,
    input in,
    input areset,
    output reg out
);

    // State encoding
    typedef enum logic [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t state, next_state;

    // State transition logic
    always @(*) begin
        case (state)
            A: begin
                next_state = (in == 1'b0) ? A : B;
                out = 1'b0;
            end
            B: begin
                next_state = (in == 1'b0) ? C : B;
                out = 1'b0;
            end
            C: begin
                next_state = (in == 1'b0) ? A : D;
                out = 1'b0;
            end
            D: begin
                next_state = (in == 1'b0) ? C : B;
                out = 1'b1;
            end
            default: begin
                next_state = A;
                out = 1'b0;
            end
        endcase
    end

    // State register with asynchronous reset
    always @(posedge clk or posedge areset) begin
        if (areset) begin
            state <= A;
        end else begin
            state <= next_state;
        end
    end

endmodule
