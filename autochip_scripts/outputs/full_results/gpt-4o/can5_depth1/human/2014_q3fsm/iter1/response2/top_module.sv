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
    logic [1:0] count; // Counter for the number of w=1 in the last three clock cycles

    // Sequential logic for state transition and output logic
    always @(posedge clk) begin
        if (reset) begin
            state <= A;
            z <= 1'b0;
            count <= 2'b00;
        end
        else begin
            state <= next_state;
            if (state == B) begin
                if(w) count <= count + 1;
            end
            if (state == C) begin
                if(w) count <= count + 1;
            end
            if (state == D) begin
                if(w) count <= count + 1;
                if (count == 2'b01) z <= 1'b1;
                else z <= 1'b0;
            end
            if (next_state == A) begin
                count <= 2'b00;
                z <= 1'b0;
            end
       end
    end

    // Next state logic (combinational logic)
    always @(*) begin
        case (state)
            A: begin
                if (s) next_state = B;
                else next_state = A;
            end
            B: next_state = C;
            C: next_state = D;
            D: begin
                next_state = B;
            end
        endcase
    end

endmodule
