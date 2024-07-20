module top_module (
    input clk,
    input resetn,
    input [3:1] r,
    output reg [3:1] g
);

    // State Encoding
    typedef enum logic [1:0] {
        S_A = 2'b00,
        S_B = 2'b01,
        S_C = 2'b10
    } state_t;

    state_t state, next_state;

    // State Flip-Flops (sequential logic)
    always_ff @(posedge clk or negedge resetn) begin
        if (!resetn)
            state <= S_A;
        else
            state <= next_state;
    end

    // State Table (combinational logic)
    always_comb begin
        next_state = state;
        case (state)
            S_A: begin
                if (r[1])
                    next_state = S_B;
                else if (r[2])
                    next_state = S_C;
                // r[3] case not needed since it does not lead to another state
            end
            S_B: begin
                if (!r[1])
                    next_state = S_A;
            end
            S_C: begin
                if (!r[2])
                    next_state = S_A;
            end
        endcase
    end

    // Output Logic
    always @(*) begin
        g = 3'b000; // Default no grant
        case (state)
            S_A: begin
                // Stay in this state
            end
            S_B: begin
                g[1] = 1; // Grant for device 1
                // Note: Device 1 continues to get grant in this state
            end
            S_C: begin
                g[2] = 1; // Grant for device 2
                // Note: Device 2 continues to get grant in this state
            end
        endcase
    end
endmodule
