module top_module (
    input clk,
    input in,
    input reset,
    output reg out
);

    // State encoding
    typedef enum reg [1:0] {
        A = 2'b00,
        B = 2'b01,
        C = 2'b10,
        D = 2'b11
    } state_t;
    
    state_t state, next_state;

    // State transition and output logic
    always @(*) begin
        case (state)
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
    
    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            state <= A;
        else
            state <= next_state;
    end

endmodule
