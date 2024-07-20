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
    
    state_t current_state, next_state;

    // State transition logic
    always @(*) begin
        case (current_state)
            A: if(in) next_state = B; else next_state = A;
            B: if(in) next_state = B; else next_state = C;
            C: if(in) next_state = D; else next_state = A;
            D: if(in) next_state = B; else next_state = C;
            default: next_state = A; // default case for safety
        endcase
    end

    // State register logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= A;
        else
            current_state <= next_state;
    end

    // Output logic
    always @(posedge clk or posedge reset) begin
        if (reset)
            out <= 1'b0;
        else begin
            case (current_state)
                A: out <= 1'b0;
                B: out <= 1'b0;
                C: out <= 1'b0;
                D: out <= 1'b1;
                default: out <= 1'b0; // default case for safety
            endcase
        end
    end
endmodule
