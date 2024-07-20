module top_module (
    input clk,
    input reset,
    input w,
    output reg z
);
    
    // Define states
    typedef enum reg [2:0] {
        A = 3'b000,
        B = 3'b001,
        C = 3'b010,
        D = 3'b011,
        E = 3'b100,
        F = 3'b101
    } state_t;

    // State register
    state_t state, next_state;

    // Sequential logic to update state on clock edge and reset
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= A; // initial state
        end else begin
            state <= next_state;
        end
    end

    // Combinational logic for next state
    always @(*) begin
        case (state)
            A: next_state = (w == 1'b0) ? A : B;
            B: next_state = (w == 1'b0) ? D : C;
            C: next_state = (w == 1'b0) ? D : E;
            D: next_state = (w == 1'b0) ? A : F;
            E: next_state = (w == 1'b0) ? D : E;
            F: next_state = (w == 1'b0) ? D : C;
            default: next_state = A; // default to state A on unknown state
        endcase
    end

    // Output logic
    always @(*) begin
        if (state == E || state == F) begin
            z = 1'b1;
        end else begin
            z = 1'b0;
        end
    end

endmodule
